from couchdb.client import Server
from api.mapping.product import Product
from api.mapping.user import User

server = Server(url="http://admin:qweasdzxc@localhost:5984/")
db = server['admin']
User.by_user.sync(db)