
COMMENT_SUCCESS = '评论成功'
COMMENT_FAIL = '评论失败'
COMMENT_AFTER_LOGIN = '请登录后评论'
SETTING_UPDATE_SUCCESS = '设置更新成功'
SETTING_UPDATE_FAIL = '设置更新失败'
PROFILE_UPDATE_SUCCESS = '资料更新成功'
PROFILE_UPDATE_FAIL = '资料更新失败'
MAX_MESSAGE_LENGTH_REACH = '消息长度最大为200'

SHARE = '分享了'
LIKE = '喜欢了'
WTA = '想吃'
ATE = '吃过'
FOLLOW = '关注了'
COLLECT = '收藏了'

REDIS_FOOD_VIEWS_KEY = 'food:{}:views'
REDIS_FOOD_RANKING_KEY = 'food_ranking'
REDIS_MESSAGES_KEY = 'message:{}:store'
REDIS_MESSAGES_UNREAD_KEY = 'message:{}:unread'

STATUS_INVALID_ARGUMENTS = '无效参数'

JSON_SUCCESS = {'status': True}
JSON_SUCCESS_WITH_DATA = lambda data: JSON_SUCCESS.update(data)
JSON_FAIL = lambda reason='':{'status':False, 'reason': 'reason'}

MAX_MESSAGE_LENGTH = 200
MAX_MESSAGES_COUNT = 1000