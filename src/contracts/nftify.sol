pragma solidity ^0.8.8;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

// import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";

//this contract inherits ERC721
contract NFTify is ERC721 {
    uint256 public tokenCounter;

    //constructor for an ERC721 is a name and symbol
    constructor() public ERC721("astronaut", "STAR") {
        tokenCounter = 0;
    }

    //a token url is a ipfs url
    //after we mint the token we are going to return the id of the token
    function uploadImage(string memory _imgHash, string memory _description)
        public
        returns (uint256)
    {
        //get number from token counter
        uint256 newNFTTokenId = tokenCounter;

        //safely mint token for the person that called the function
        _safeMint(msg.sender, newNFTTokenId);

        //set the token uri of the token id of the uri passed
        _setTokenURI(newNFTTokenId, _imgHash);

        //increment the counter
        tokenCounter = tokenCounter + 1;

        //return the token id
        return newNFTTokenId;
    }
}
