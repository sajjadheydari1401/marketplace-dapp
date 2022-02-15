pragma solidity >=0.5.16;

contract Marketplace {
    string public name;
    uint public productCount = 0;
    mapping(uint => Product) public products;

    struct Product {
        uint id;
        string name;
        uint price;
        address payable owner;
        bool purchased;
    }

    event ProductCreated(     
        uint id,
        string name,
        uint price,
        address payable owner,
        bool purchased
    );

    event ProductPurchased(     
        uint id,
        string name,
        uint price,
        address payable owner,
        bool purchased
    );


    constructor() public {
        name = "Simon Marketplace";
    }

    function createProduct(string memory _name, uint _price) public {
        // require a valid name
        require(bytes(_name).length > 0);

        // require a valid price
        require(_price > 0);

        // increment product count
        productCount ++;

        // create the product
        products[productCount] = Product(productCount, _name, _price, msg.sender, false); 

        // trigger an event
        emit ProductCreated(productCount, _name, _price, msg.sender, false);

    }

    function purchaseProduct(uint _id) public payable {

        // fecth the product
        Product memory _product = products[_id];

        // fecth the ownder
        address payable _seller = _product.owner;

        // make sure product has a valid id
        require(_product.id > 0 && _product.id <= productCount);

        // require there is enough Ether in the transaction
        require(msg.value >= _product.price);

        // require that the product has not been purchased already
        require(!_product.purchased);

        // require that buyer is not the seller
        require(_seller != msg.sender);

        // transfer ownership to buyer
        _product.owner = msg.sender;

        // mark as purchased
        _product.purchased = true;

        // update the product
        products[_id] = _product;

        // Pay seller by sending Ether
        address(_seller).transfer(msg.value);

        // Trigger an event
        emit ProductPurchased(productCount, _product.name, _product.price, msg.sender, true);


    }
}