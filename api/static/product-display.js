/** @jsx React.DOM */

var BrandHeader = React.createClass({
    render: function () {
        return (
            <div class="bs-header">
                <div class="container">
                    <h1>{this.props.brand}</h1>
                    <p>{this.props.desc}</p>
                </div>
            </div>
            );
    }
});


var Category = React.createClass({

    render: function () {
        return <li><a href={'#' + this.props.data[3]}>{this.props.data[1]}</a></li>
    }
});


var Brand = React.createClass({
    refreshSpy: React.autoBind(function (brandName) {
        $('[data-spy="scroll"]').each(function () {
            var $spy = $(this).scrollspy('refresh')
        });
    }),
    loadBrand: React.autoBind(function (brandName) {
        $.ajax({
            type: 'GET',
            url: '/brands?name=' + brandName,
            dataType: 'json',
            async: false,
            success: function (data) {
                this.setState({brands: data.rows});
            }.bind(this)
        });
    }),
    handleClick: React.autoBind(function (event) {
        if (this.props.handleBrandChange) {
            this.props.handleBrandChange(event.target.firstChild.data);
            setTimeout(this.refreshSpy, 1000);
        }
    }),
    getInitialState: function() {
        return {brands: []}
    },
    componentDidMount: function () {
        this.loadBrand(this.props.data.key[0]);
    },
    render: function () {
        var categories = this.state.brands.map(function (spec) {
            return <Category data={spec.key} />;
        });
        return (
            <li>
                <a href={'#' + this.props.data.value} onClick={this.handleClick}>{this.props.data.key[0]}</a>
                <ul class="nav">
                {categories}
                </ul>
            </li>
            )
    }
});


var BrandList = React.createClass({
    render: function () {
        var brands = this.props.data.map(function (product) {
            return <Brand data={product} handleBrandChange={this.props.handleBrandChange} />;
        }.bind(this));
        return (
            <div class="bs-sidebar">
                <ul class="nav bs-sidenav">
                {brands}
                </ul>
            </div>
            );
    }
});


var Product = React.createClass({
    render: function () {
        return (
            <div>{this.props.data.value.brand}
                <br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
            </div>
            )
    }
});


var ProductOnCategory = React.createClass({
    loadProduct: React.autoBind(function (brandName, category) {
        $.ajax({
            type: 'GET',
            url: '/products?name=' + brandName + '&ca=' + category,
            dataType: 'json',
            async: false,
            success: function (data) {
                this.setState({products: data.rows});
            }.bind(this)
        });
    }),
    getInitialState: function () {
        console.log("product on category init ");
        return {products: []};

    },
    componentDidMount: function () {
        this.loadProduct(this.props.name[0], this.props.name[1]);
    },
    render: function() {
        var products = this.state.products.map(function (product) {
            return <Product data={product} />
        });
        return (
            <div>
                <h3 id={this.props.name[3]}>{this.props.name[1]}</h3>
            {products}
            </div>
            );
    }
});


var ProductList = React.createClass({
    render: function () {
        var productOnCategory = this.props.data.map(function (category) {
            return <ProductOnCategory name={category.key} />;
        });
        return (
            <div class="bs-docs-section" id={this.props.en}>
                <div class="page-header">
                    <h1>{this.props.name}</h1>
                </div>
            {productOnCategory}
            </div>
            );
    }
});

var lectotype = React.createClass({
    loadDesc: React.autoBind(function (brandName) {
        $.ajax({
            type: 'GET',
            url: '/brand/desc?name=' + brandName,
            dataType: 'json',
            async: false,
            success: function (data) {
                this.setState({brand: data.rows[0].key, desc: data.rows[0].value[0], brand_en: data.rows[0].value[1]});
            }.bind(this)
        });
    }),
    loadBrands: React.autoBind(function () {
        $.ajax({
            type: 'GET',
            url: '/brands',
            dataType: 'json',
            async: false,
            success: function (data) {
                this.setState({brands: data.rows});
            }.bind(this)
        });
    }),
    loadBrand: React.autoBind(function (brandName) {
        $.ajax({
            type: 'GET',
            url: '/brands?name=' + brandName,
            dataType: 'json',
            async: false,
            success: function (data) {
                this.setState({categories: data.rows});
            }.bind(this)
        });
    }),
    getInitialState: function () {
        return {brands: [], brand: "", desc: "", brand_en: "", categories: []};
    },
    componentDidMount: function () {
        this.loadBrands();
        this.loadDesc(this.state.brands[0].key[0]);
        this.loadBrand(this.state.brands[0].key[0])
    },
    handleBrandChange: React.autoBind(function (brandName) {
        this.loadDesc(brandName);
        this.loadBrand(brandName);
    }),
    render: function () {
        return (
            <div>
                <BrandHeader brand={this.state.brand} desc={this.state.desc} />
                <div class="container bs-docs-container">
                    <div class="row">
                        <div class="col-lg-3">
                            <BrandList data={this.state.brands} handleBrandChange={this.handleBrandChange} />
                        </div>
                        <div class="col-lg-9">
                            <ProductList name={this.state.brand} en={this.state.brand_en} data={this.state.categories} />
                        </div>
                    </div>
                </div>
            </div>
        );
    }
});

React.renderComponent(
  <lectotype />,
  document.getElementById('lectotype')
);