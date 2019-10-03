from urllib import parse
import requests
from utils import *
from src.models.brewery import Brewery
from config import Config as _CONF
from config import ContentTypeIdList
import json


# 브루어리를 받아 locationBasedList Tour API를 호출하는 함수
def get_location_based_list(brewery: Brewery, radius=20000, **payload) -> list:
    # TODO ContentTypeId 적용
    serviceName = "locationBasedList"
    mapX, mapY = brewery.location[0], brewery.location[1]
    params = {
        **payload,
        "mapX": str(mapX),
        "mapY": str(mapY),
        "arrange": "S",
        "radius": str(radius)
    }
    query = parse.urlencode(params)
    res = requests.get(f"{_CONF.base_url}/{serviceName}?ServiceKey={_CONF.ServiceKey}&{query}")
    data = json.loads(res.text)
    logger.debug(f'location based list {data}')
    item = data['response']['body']['items']['item']

    return item


# 브루어리를 받아, (거리|컨텐츠타입)에 따라 서비스에 필요한 정보 추출 후 리턴
def get_brewery_page(brewery: Brewery, numOfRows=10, pageNo=1, ContentTypeId=None, **kwargs) -> dict:
    payload = {
        "numOfRows": str(numOfRows),
        "pageNo": str(pageNo),
        "MobileOS": "ETC",
        "MobileApp": "Mac-Tour",
        "_type": "json"
    }
    if ContentTypeId not in [i.value for i in ContentTypeIdList]:
        # 유효한 ContentTypeId 인지?
        ContentTypeId = None
    else:
        payload = {**payload,
                   "contentTypeId": str(ContentTypeId)}

    logger.debug(payload)

    item = get_location_based_list(brewery, **payload)
    logger.debug(item)

    body = {}

    body['brewery'] = brewery.to_dict()
    body['contentTypeId'] = ContentTypeId
    body['content'] = []
    for each in item:
        # content_id = each['contentid']
        body['content'].append(each)

    return body


# contentId과 contentTypeId를 받아, 필요한 서비스 세부 정보 리턴
def get_content_detail(content_id, content_type_id) -> dict:
    pass


# 공통정보 조회(상세정보1)
def get_detail_common(content_id, content_type_id):
    pass


# 소개정보 조회(상세정보2)
def get_detail_intro():
    pass


# 반복정보 조회(상세정보3
def get_detail_info(content_id):
    # detailInfo에서는 여행코스, 숙박, 기타를 구분해야 한다.
    pass


# 이미지정보 조회(상세정보4)
def get_detail_image(content_id, content_type_id: ContentTypeIdList):
    pass
