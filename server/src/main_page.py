from src.database import db
from utils import *

_banner_list = ['title', 'url_imgs']
_breweries_list = ['name', 'url_img', 'region']


def get_main_page(region):
    logger.debug(f'in get_main_page')
    ret = {}

    banner = db.collection('banner').stream()
    brewery = db.collection('brewery').where('region', '==', region).stream()

    ret['banners'] = list(map(lambda x: {key: x.to_dict()[key] for key in _banner_list}, banner))
    logger.debug(f'{ret}')
    ret['breweries'] = list(map(lambda x: {key: x.to_dict()[key] for key in _breweries_list}, brewery))
    logger.debug(f'{ret}')

    return ret
