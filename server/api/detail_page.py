from lib.flask_restplus import Resource, Namespace, reqparse
from src.detail_page import *
from src.database import db

ns_dp = Namespace(name='detail-page', description='Detail-Page')


@ns_dp.route('/')
class Index(Resource):

    # @ns_dp.marshal_with(resource, as_list=True, code=200, description='메인페이지를 위한 API')
    @ns_dp.doc('브루어리 상세페이지', params={'BreweryName': '브루어리 이름', 'ContentTypeId': '투어 컨텐츠 타입'})
    def get(self):
        parser = reqparse.RequestParser()
        parser.add_argument('BreweryName', type=str, required=True, help='브루어리 이름')
        parser.add_argument('ContentTypeId', type=int, required=False, help='투어 컨텐츠 타입')
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
