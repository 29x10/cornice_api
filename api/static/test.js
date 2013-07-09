/** @jsx React.DOM */

var BrandHeader = React.createClass({
    render: function () {
        return (
            <div class="container">
                <h1>{this.props.brand}</h1>
                <p>{this.props.desc}</p>
            </div>
            );
    }
});


var TestItem = React.createClass({
    render: function () {
        return <li>{this.props.name}</li>
    }
});

var TestCase = React.createClass({
    render: function () {
        var tests = this.props.data.map(function (testItem) {
            return <TestItem name={testItem.key.brand} />
        });
        return (
            <ul>{tests}</ul>
            );
    }
});

var lectotype = React.createClass({
    loadDesc: React.autoBind(function (brandName) {
        $.ajax({
            type: 'GET',
            url: '/brand/desc?name=' + brandName,
            dataType: 'json',
            success: function (data) {
                this.setState({brand: data.rows[0].key.brand, desc: data.rows[0].value.desc});
            }.bind(this)
        });
    }),
    loadBrands: React.autoBind(function () {
        $.ajax({
            type: 'GET',
            url: 'http://localhost:5001/brands',
            dataType: 'json',
            async: false,
            crossDomain: true,
            success: function (data) {
                this.setState({brands: data.rows});
            }.bind(this)
        });
    }),
    getInitialState: function () {
        return {brands: [], brand: "", desc: ""};
    },
    componentDidMount: function () {
        this.loadBrands();
        this.loadDesc(this.state.brands[0].key.brand);
    },
    render: function () {
        return (
            <div>
                <BrandHeader brand={this.state.brand} desc={this.state.desc} />
                <TestCase data={this.state.brands} />
            </div>
        );
    }
});

React.renderComponent(
    <lectotype />,
    document.getElementById('lectotype')
);