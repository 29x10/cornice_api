from couchdb.design import ViewDefinition
from couchdb.mapping import Document, TextField, ListField


class Product(Document):
    db_type = TextField(default='product')
    spec =  TextField()
    brand = TextField()
    category = TextField()
    cover = TextField()
    images = ListField(TextField)


    brand_list = ViewDefinition('product', 'brand_list', '''
        function(doc) {
            if (doc.db_type == 'product') {
                emit(doc.brand, doc.category);
            }
        }''','''
        function (keys, values, rereduce) {
            var u = {}, a = [];
            for (var i = 0; i < values.length; i++) {
                if (!u.hasOwnProperty(values[i])) {
                    a.push(values[i]);
                    u[values[i]] = 1;
                }
            }
        return a;
        }''')

    product_list = ViewDefinition('product', 'product_list', '''
        function(doc) {
            if (doc.db_type == 'product') {
                emit([doc.brand, doc.category], doc);
            }
        }''')


    def __init__(self, spec, brand, category, cover, images):
        super(Product, self).__init__()
        self.spec = spec
        self.brand = brand
        self.category = category
        self.cover = cover
        self.images = images
