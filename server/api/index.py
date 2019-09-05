from lib.flask_restplus import Resource, Namespace

ns = Namespace(name='', description='version-1')


@ns.route('/<param>')
class Index(Resource):

    @ns.doc('Index', params={'param': 'param message'})
    def get(self, param):
        return 'Index Message, param: {}'.format(param)
