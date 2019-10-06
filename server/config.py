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
    관광 = 12
    문화시설 = 14
    행사 = 15
    숙박 = 32
    쇼핑 = 38
    음식점 = 39
