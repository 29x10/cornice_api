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
            var category_dict = {};
            for (var index in values) {
                category_dict[values[index]] = values[index];
            }
            var category = [];
            for (var index in category_dict) {
                category.push(index);
            }
            return category
        }''')


    def __init__(self, spec, brand, category, cover, images):
        super(Product, self).__init__()
        self.spec = spec
        self.brand = brand
        self.category = category
        self.cover = cover
        self.images = images
