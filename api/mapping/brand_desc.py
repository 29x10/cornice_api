from couchdb.design import ViewDefinition
from couchdb.mapping import Document, TextField


class BrandDesc(Document):

    db_type = TextField(default='brand_desc')
    name = TextField()
    desc = TextField()


    by_name = ViewDefinition('brand_desc', 'by_name', '''
        function (doc) {
            if (doc.db_type == 'brand_desc') {
                emit(doc.name, doc.desc);
            }
        }''')


    def __init__(self, name, desc):
        super(BrandDesc, self).__init__()
        self.name = name
        self.desc = desc
