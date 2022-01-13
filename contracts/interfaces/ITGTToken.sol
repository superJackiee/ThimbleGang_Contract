// SPDX-License-Identifier: MIT
pragma solidity ^0.7.6;
pragma abicoder v2;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

interface ITGTToken is IERC721 {
    struct Tgt {
        uint256 charvision;
        uint256 score;
        uint256 rarityIndex;
        string gender;
    }

    function mint(
        address _account,
        string memory _ipfsUrl,
        uint256 _charvision,
        uint256 _score,
        uint256 _rarityIndex,
        string memory _gender
    ) external;

    function transfer(
        address _from,
        address _to,
        uint256 _tokenId
    ) external;

    function burn(uint256 _tokenId) external;

    function getTgts(uint256[] memory _tokenIds)
        external
        returns (Tgt[] memory);
}
