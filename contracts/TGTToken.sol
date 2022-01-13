// SPDX-License-Identifier: MIT
pragma solidity ^0.7.6;
pragma abicoder v2;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./interfaces/ITGTToken.sol";

contract TGTToken is ERC721, Ownable, ITGTToken {
    uint256 public numTGT;

    mapping(uint256 => Tgt) public tgts;

    event TGTTokenMinted(
        address indexed account,
        uint256 tokenId,
        uint256 _charvision,
        uint256 _score,
        uint256 _rarityIndex,
        string _gender
    );

    event TGTTokenBurned(uint256 tokenId);

    constructor() public ERC721("ThimbleGang Token", "TGT") {
        _setBaseURI("ipfs://TGTToken/");
    }

    /**
     * @dev mint tgt token
     * @param _ipfsUrl url to ipfs storage
     * @param _charvision Charvision of ThimbleGang
     * @param _score Score of ThimbleGang
     * @param _rarityIndex RarityIndex of ThimbleGang
     * @param _gender gender of ThimbleGang
     */

    function mint(
        address _account,
        string memory _ipfsUrl,
        uint256 _charvision,
        uint256 _score,
        uint256 _rarityIndex,
        string memory _gender
    ) external override onlyOwner {
        Tgt storage t = tgts[numTGT];
        t.charvision = _charvision;
        t.score = _score;
        t.rarityIndex = _rarityIndex;
        t.gender = _gender;
        _mint(_account, numTGT);
        _setTokenURI(numTGT, _ipfsUrl);
        emit TGTTokenMinted(
            _account,
            numTGT,
            _charvision,
            _score,
            _rarityIndex,
            _gender
        );
        numTGT++;
    }

    function transfer(
        address _from,
        address _to,
        uint256 _tokenId
    ) external override onlyOwner {
        transferFrom(_from, _to, _tokenId);
    }

    /**
     * @dev burn tgt at end of sale
     * @param _tokenId id of token to burn
     */

    function burn(uint256 _tokenId) external override onlyOwner {
        delete tgts[_tokenId];
        _burn(_tokenId);
        emit TGTTokenBurned(_tokenId);
    }

    /**
     * @dev get list of tgt objects by ids
     * @param _tokenIds list of ids of token to get
     */

    function getTgts(uint256[] memory _tokenIds)
        external
        view
        override
        returns (Tgt[] memory)
    {
        Tgt[] memory tgts_temp = new Tgt[](_tokenIds.length);
        for (uint256 i = 0; i < _tokenIds.length; i++) {
            tgts_temp[i] = tgts[_tokenIds[i]];
        }

        return tgts_temp;
    }
}
