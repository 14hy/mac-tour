from src.database import db
from lib.flask_restplus import Resource, Namespace, fields
from src.main_page import get_main_page

banners = db.collection('banner')

ns_mp = Namespace(name='main-page', description='Main-Page')

res_banners = ns_mp.model(name='banners', model={
    'title': fields.String(description='배너 제목'),
    'url_imgs': fields.List(fields.String, description='이미지 URL')
})

res_breweries = ns_mp.model(name='breweries', model={
    'name': fields.String(description='양조장 이름'),
    'url_img': fields.String(description='양조장 이미지'),
    'region': fields.String(description='양조장 지역')
})

resource = ns_mp.model(name='main-page', model={
    'banners': fields.List(fields.Nested(res_banners)),
    'breweries': fields.List(fields.Nested(res_breweries))
})


@ns_mp.route('/<region>')
class Index(Resource):

    @ns_mp.marshal_with(resource, as_list=True, code=200, description='메인페이지를 위한 API')
    @ns_mp.doc('Index')
    def get(self, region):
        ret = get_main_page(region)
        return ret
