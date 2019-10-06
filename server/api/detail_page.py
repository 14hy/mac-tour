from lib.flask_restplus import Resource, Namespace, reqparse
from src.detail_page import *
from src.database import db

ns_dp = Namespace(name='detail-page', description='Detail-Page')


@ns_dp.route('/')
class Index(Resource):

    # @ns_dp.marshal_with(resource, as_list=True, code=200, description='메인페이지를 위한 API')
    @ns_dp.doc('브루어리 상세페이지', params={'BreweryName': '브루어리 이름', 'ContentTypeId': '[관광, 문화시설, 행사, 숙박, 쇼핑, 맛집]'})
    def get(self):
        parser = reqparse.RequestParser()
        parser.add_argument('BreweryName', type=str, required=True, help='브루어리 이름')
        parser.add_argument('ContentTypeId', required=False, help='투어 컨텐츠 타입')
        args = parser.parse_args(strict=True)

        # BreweryName으로 브루어리 검색
        brewery = db.collection('brewery').where('name', '==', args['BreweryName']).stream()
        try:
            brewery = Brewery.from_dict(next(iter(brewery)).to_dict())
        except StopIteration:
            return f'Developing | NameNotFound'

        body = get_brewery_page(brewery, **args)

        return body, 201


@ns_dp.route('/brewery')
class Index(Resource):

    # @ns_dp.marshal_with(resource, as_list=True, code=200, description='메인페이지를 위한 API')
    @ns_dp.doc('상세페이지 - 브루어리 ', params={'BreweryName': '브루어리 이름'})
    def get(self):
        parser = reqparse.RequestParser()
        parser.add_argument('BreweryName', type=str, required=True, help='브루어리 이름')
        args = parser.parse_args(strict=True)

        # BreweryName으로 브루어리 검색
        brewery = db.collection('brewery').where('name', '==', args['BreweryName']).stream()
        try:
            brewery = Brewery.from_dict(next(iter(brewery)).to_dict())
        except StopIteration:
            return f'Developing | NameNotFound'

        body = {}
        body['brewery'] = brewery.to_dict()

        return body, 201


@ns_dp.route('/tour/info')
class Index(Resource):

    # @ns_dp.marshal_with(resource, as_list=True, code=200, description='메인페이지를 위한 API')
    @ns_dp.doc('상세페이지 - 투어 정보 ', params={'ContentId': '투어 아이디', 'ContentTypeId': '[관광, 문화시설, 행사, 숙박, 쇼핑, 맛집]'})
    def get(self):
        parser = reqparse.RequestParser()
        parser.add_argument('ContentId', type=int, required=True, help='투어 아이디')
        parser.add_argument('ContentTypeId', required=True, help='[관광, 문화시설, 행사, 숙박, 쇼핑, 맛집]')
        args = parser.parse_args(strict=True)
        ContentTypeId = args['ContentTypeId']

        print(ContentTypeId)

        body = get_detail_info(args['ContentId'], args['ContentTypeId'])

        return body, 201


@ns_dp.route('/tour/image')
class Index(Resource):

    # @ns_dp.marshal_with(resource, as_list=True, code=200, description='메인페이지를 위한 API')
    @ns_dp.doc('상세페이지 - 투어 이미지 ', params={'ContentId': '투어 아이디'})
    def get(self):
        parser = reqparse.RequestParser()
        parser.add_argument('ContentId', type=int, required=True, help='투어 아이디')
        args = parser.parse_args(strict=True)

        body = get_detail_image(args['ContentId'])

        return body, 201
