from urllib import parse
import requests
from utils import *
from src.models.brewery import Brewery
from config import Config as _CONF
from config import ContentTypeIdList
import json


def _validate_content_type_id(ContentTypeId):
    """ContentTypeId validator

    :return: ContentTypeIdList value or False if not valid or None
    """
    # 유효한 ContentTypeId 인지?
    if ContentTypeId is None:
        return False
    elif str(ContentTypeId) in list(ContentTypeIdList.__members__):
        return ContentTypeIdList[ContentTypeId].value
    elif int(ContentTypeId) in [i.value for i in ContentTypeIdList]:
        return ContentTypeId
    else:
        return False


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
    ContentTypeId = _validate_content_type_id(ContentTypeId)
    if ContentTypeId:
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
def get_detail_info(content_id, content_type_id):
    # detailInfo에서는 여행코스, 숙박, 기타를 구분해야 한다.
    content_type_id = _validate_content_type_id(content_type_id)
    if not content_type_id:
        return {
            'error': 'wrong content type id'
        }

    payload = {
        # "numOfRows": str(numOfRows),
        # "pageNo": str(pageNo),
        "MobileOS": "ETC",
        "MobileApp": "Mac-Tour",
        "_type": "json",
        "contentId": content_id,
        "contentTypeId": int(content_type_id)
    }
    serviceName = 'detailInfo'

    query = parse.urlencode(payload)
    res = requests.get(f"{_CONF.base_url}/{serviceName}?ServiceKey={_CONF.ServiceKey}&{query}")
    data = json.loads(res.text)
    logger.debug(f'get_detail_info {data}')
    try:
        item = data['response']['body']['items']['item']
    except TypeError:
        return {
            'error': '잘못된 투어아이디 + 컨텐츠 페어 또는 서버오류'
        }

    return item


# 이미지정보 조회(상세정보4)
def get_detail_image(content_id):
    payload = {
        # "numOfRows": str(numOfRows),
        # "pageNo": str(pageNo),
        "MobileOS": "ETC",
        "MobileApp": "Mac-Tour",
        "_type": "json",
        "contentId": content_id
    }
    serviceName = 'detailImage'

    query = parse.urlencode(payload)
    res = requests.get(f"{_CONF.base_url}/{serviceName}?ServiceKey={_CONF.ServiceKey}&{query}")
    data = json.loads(res.text)
    logger.debug(f'get_detail_info {data}')
    item = data['response']['body']['items']['item']

    return item
