var path = require('path');
var webpack = require('webpack');
var glob = require('glob');
var polyfill = require("babel-polyfill");
/*
extract-text-webpack-plugin插件，
有了它就可以将你的样式提取到单独的css文件里，
妈妈再也不用担心样式会被打包到js文件里了。
 */
var ExtractTextPlugin = require('extract-text-webpack-plugin');
/*
html-webpack-plugin插件，重中之重，webpack中生成HTML的插件，
具体可以去这里查看https://www.npmjs.com/package/html-webpack-plugin
 */
var HtmlWebpackPlugin = require('html-webpack-plugin');

var templateFiles = getEntry('dev/templates/**/*.html');
var jsFiles = getEntry('dev/js/**/*.js');
var chunks = Object.keys(templateFiles.input);

console.log("------------------------------------------------------------------------------------");
console.log("\n重新打包时间：" + new Date() + "\n");
console.log("------------------------------------------------------------------------------------");
// console.log(jsFiles.input)
module.exports = {
    entry: jsFiles.input,

    output: {
        path: path.join(__dirname, 'public/static'), //输出目录的配置，模板、样式、脚本、图片等资源的路径配置都相对于它
        publicPath: '/public/static/',   // 服务器路径
        filename: 'js/[name].js',            //每个页面对应的主js的生成配置
        chunkFilename: 'js/[id].chunk.js'   //chunk生成的配置
    },
    module: {
        loaders: [ //加载器，关于各个加载器的参数配置，可自行搜索之。
            {
                test: /\.css$/,
                //配置css的抽取器、加载器。'-loader'可以省去
                loader: ExtractTextPlugin.extract('style-loader', 'css-loader')
            },
            {
                test: /\.less$/,
                //配置less的抽取器、加载器。中间!有必要解释一下，
                //根据从右到左的顺序依次调用less、css加载器，前一个的输出是后一个的输入
                //你也可以开发自己的loader哟。有关loader的写法可自行谷歌之。
                loader: ExtractTextPlugin.extract('css!less')
            },

            {
                //html模板加载器，可以处理引用的静态资源，默认配置参数attrs=img:src，处理图片的src引用的资源
                //比如你配置，attrs=img:src img:data-src就可以一并处理data-src引用的资源了，就像下面这样
                test: /\.html$/,
                loader: "html?attrs=img:src img:data-src"
            },
            {
                test: /\.js?$/,
                exclude: /(node_modules|bower_components)/,
                loader: 'babel',
                query: {
                    presets: ['es2015']
                }
            },
            {
                //文件加载器，处理文件静态资源
                test: /\.(woff|woff2|ttf|eot|svg)(\?v=[0-9]\.[0-9]\.[0-9])?$/,
                loader: 'file-loader?name=./fonts/[name].[ext]'
            },

            {
                //图片加载器，雷同file-loader，更适合图片，可以将较小的图片转成base64，减少http请求
                //如下配置，将小于8192byte的图片转成base64码
                test: /\.(png|jpg|gif)$/,
                loader: 'url-loader?limit=8192&name=./img/[hash].[ext]'
            }
        ]
    },
    plugins: [
        new webpack.optimize.CommonsChunkPlugin({
            name: 'vendors', // 将公共模块提取，生成名为`vendors`的chunk
            chunks: chunks, //提取哪些模块共有的部分
            minChunks: chunks.length // 提取至少3个模块共有的部分
        }),

        new ExtractTextPlugin('css/[name].css'), //单独使用link标签加载css并设置路径，相对于output配置中的publickPath

        new webpack.HotModuleReplacementPlugin() //热加载
    ],
    // 使用webpack-dev-server，提高开发效率
    devServer: {
        contentBase: './',
        host: 'localhost',
        port: 8111, //默认8080
        inline: true, //可以监控js变化
        hot: true, //热启动
    }
};

var configNames = templateFiles.configNames;
configNames.forEach(function(configName) {
    var config = {};
    //生成的html存放路径，相对于path
    config.filename = "../../" + configName.modelName + "/templates/" + configName.modelName + "/" + configName.baseName + ".html";
    //html模板路径
    config.template = "./dev/templates/" + configName.modelName + "/" + configName.baseName + ".html";
    //js插入的位置，true/'head'/'body'/false
    config.inject = "head";
    //为静态资源生成hash值
    config.hash = true;
    //需要引入的chunk，不配置就会引入所有页面的资源
    config.chunks = ["vendors", configName.modelName + "_" + configName.baseName];
    //压缩HTML文件
    config.minify = {
        removeComments: true, //移除HTML中的注释
        collapseWhitespace: false //删除空白符与换行符
    };
    // console.log(config);

    module.exports.plugins.push(new HtmlWebpackPlugin(config));
});

function getEntry(globPath, pathDir) {
    var files = glob.sync(globPath);
    var entries = {},
        entry, dirname, basename, pathname, extname, entryname;
    entries.input = {};
    entries.configNames = [];
    var reg = /[a-zA-Z0-9]+$/;

    for (var i = 0; i < files.length; i++) {
        entry = files[i];
        dirname = path.dirname(entry);
        extname = path.extname(entry);
        basename = path.basename(entry, extname);
        entryname = reg.exec(dirname)[0] + "_" + basename;
        pathname = path.join(dirname, basename);
        pathname = pathDir ? pathname.replace(new RegExp("^" + pathDir), "") : pathname;
        // entries[pathname] = ['./' + entry];

        entries.input[entryname] = [];
        entries.input[entryname].push("babel-polyfill");
        entries.input[entryname].push("./" + entry);
        // entries.input[entryname] = './' + entry;
        entries.configNames[i] = {};
        entries.configNames[i].baseName = basename;
        entries.configNames[i].pathName = "./" + entry;
        entries.configNames[i].modelName = reg.exec(dirname)[0];
    }
    return entries;
}
