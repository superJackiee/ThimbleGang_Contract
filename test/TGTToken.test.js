const TGTToken = artifacts.require('TGTToken');
const { toWei, toBN } = web3.utils;
const ZERO_ADDRESS = '0x0000000000000000000000000000000000000000';

contract('TGTToken', function ([alice, bob, carol, eve, david]) {
    before(async function () {
        this.tgtToken = await TGTToken.new({ from: alice });
    });

    context("Test mint function", () => {
        it("should mint success", async function () {
            const tokenId = 0;
            await this.tgtToken.mint(bob, "FACE3223", "Token1", "Male", { from: alice });
            const tgt = await this.tgtToken.tgts(tokenId);
            const tokencount = await this.tgtToken.numTGT();
            assert.equal(tgt.name.toString(), "Token1");
            assert.equal(tgt.gender.toString(), "Male");
            assert.equal(tokencount.toString(), '1');
        })
    });

    context("Test transfer function", () => {
        it("should transfer success", async function () {
            const tokenId = 0;
            await this.tgtToken.approve(alice, tokenId, { from: bob });
            await this.tgtToken.transfer(bob, eve, tokenId, { from: alice });
            const ownerOfToken = await this.tgtToken.ownerOf(tokenId);
            assert.equal(ownerOfToken, eve);
        })
    });

    context("Test get TGT tokens function", () => {
        it("should get tgts success", async function () {
            const tgts = await this.tgtToken.getTgts([0]);
            assert.equal(tgts[0].name.toString(), "Token1");
        })
    })
})