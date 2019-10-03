from enum import Enum


class Config(object):
    level = 'DEBUG'

    version = 'MAC-TOUR'
    title = 'MAC-TOUR'
    desc = '2019 스마트 관광 공모전 출품작'
    host = '0.0.0.0'
    port = 5000
    debug = True
    serviceAccount = "/Users/minhyeoklee/private_keys/mac-tour-251517-0bf342dd27e3.json"
    project_id = "mac-tour-251517"

    base_url = 'http://api.visitkorea.or.kr/openapi/service/rest/KorService'
    ServiceKey = ""


class ContentTypeIdList(Enum):
    관광지 = 12
    문화시설 = 14
    축제 = 15
    여행코스 = 25
    레포츠 = 28
    숙박 = 32
    쇼핑 = 38
    음식점 = 39
