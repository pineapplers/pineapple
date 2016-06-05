
def comma_splitter(tag_string):
    tag_string = tag_string.replace(' ', '').replace('，', ',')
    return [t.strip().lower() for t in tag_string.split(',') if t.strip()]
    