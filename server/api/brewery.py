from src.database import db
from lib.flask_restplus import Resource, Namespace, reqparse
from src.models.brewery import Brewery
from utils import logger

banners = db.collection('banner')

ns_b = Namespace(name='brewery', description='Brewery')


@ns_b.route('/')
class Index(Resource):
    @ns_b.doc(params={'desc': 'desc', 'available_day': 'available_day', 'price': 'price', 'region': 'region',
                      'url_apply': 'url_apply',
                      'url_logo': 'url_logo', 'url_img': 'url_img', 'home_page': 'home_page',
                      'location_mapY': 'location_mapY', 'available': 'available', 'name': 'name',
                      'location_mapX': 'location_mapX'})
    def post(self):
        parser = reqparse.RequestParser()
        parser.add_argument('desc', type=str, required=True, help='브루어리 이름')
        parser.add_argument('available_day', type=str, required=False, help='투어가 가능한 날')
        parser.add_argument('price', type=int, required=False, help='브루어리 투어 가격')
        parser.add_argument('region', type=str, required=False, help='브루어리 지역')
        parser.add_argument('url_apply', type=str, required=False, help='브루어리 신청')
        parser.add_argument('url_logo', type=str, required=False, help='브루어리 로고')
        parser.add_argument('url_img', type=str, required=False, help='')
        parser.add_argument('home_page', type=str, required=False, help='브루어리 사이트')
        parser.add_argument('location_mapX', type=float, required=False, help='브루어리 좌표 - longitude')
        parser.add_argument('location_mapY', type=float, required=False, help='브루어리 좌표 - latitude')
        parser.add_argument('available', type=bool, required=False, help='투어 가능 여부')
        parser.add_argument('name', type=str, required=False, help='투어 이름')
        args = parser.parse_args(strict=True)

        location = [args['location_mapX'], args['location_mapY']]
        args.pop('location_mapX')
        args.pop('location_mapY')
        args['location'] = location
        logger.debug(str(args))

        b = Brewery(**args)
        db.collection('brewery').document().set(b.to_dict())
        return 201
