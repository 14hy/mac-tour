from src.database import db
from utils import *

_banner_list = ['title', 'url_imgs']
_breweries_list = ['name', 'url_img', 'region']


@basic_logger
@basic_timer
def get_main_page(region) -> dict:
    """

    :param region:
    :return:
    """
    ret = {}

    banner = db.collection('banner').stream()
    if region == 'all':
        brewery = db.collection('brewery').stream()
    else:
        brewery = db.collection('brewery').where('region', '==', region).stream()

    ret['banners'] = list(map(lambda x: {key: x.to_dict()[key] for key in _banner_list}, banner))
    logger.debug(f'{ret}')
    ret['breweries'] = list(map(lambda x: {key: x.to_dict()[key] for key in _breweries_list}, brewery))
    logger.debug(f'{ret}')

    return ret
