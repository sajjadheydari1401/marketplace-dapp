const { assert } = require("chai");

/* eslint-disable no-undef */
const Marketplace = artifact.require('./Marketplace.sol');

contract('Marketplace', (accounts) => {
    let marketplace

    before(async () => {
        marketplace = await Marketplace.deployed();
    })

    describe('deployment', async () => {
        it('deploys successfully', async () => {
            const address = await marketplace.address;
            assert.notEqual(address, 0x0);
            assert.notEqual(address, '');
            assert.notEqual(address, null);
            assert.notEqual(address, undefined);
        });

        it('has a name', async () => {
            const name = await marketplace.name();
            assert.equal(name, "Simon Marketplace");
        })
    })
})