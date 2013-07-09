from couchdb.design import ViewDefinition
from couchdb.mapping import Document, TextField, ListField


class Product(Document):
    db_type = TextField(default='product')
    spec =  TextField()
    brand = TextField()
    category = TextField()
    cover = TextField()
    images = ListField(TextField)


    by_brand = ViewDefinition('product', 'by_brand', '''
        function(doc) {
            if (doc.db_type == 'product') {
                emit(doc.brand, doc.category);
            }
        }''','''
        function(keys, values, rereduce) {
            var categories = []
            for (var index in values) {
                categories.push(values[index]);
            }
            return categories;
        }''')


    def __init__(self, spec, brand, category, cover, images):
        super(Product, self).__init__()
        self.spec = spec
        self.brand = brand
        self.category = category
        self.cover = cover
        self.images = images
