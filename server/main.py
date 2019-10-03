from flask import Flask
from lib.flask_restplus import Api
from config import Config as _CONF
from flask_cors import CORS

app = Flask(__name__)
api = Api(version=_CONF.version, title=_CONF.title, description=_CONF.desc)
CORS(app)

from api.index import ns
from api.main_page import ns_mp
from api.detail_page import ns_dp
from api.brewery import ns_b

api.add_namespace(ns)
api.add_namespace(ns_mp)
api.add_namespace(ns_dp)
api.add_namespace(ns_b)
api.init_app(app)

if __name__ == "__main__":
    app.run(host=_CONF.host, port=_CONF.port, debug=_CONF.debug)
