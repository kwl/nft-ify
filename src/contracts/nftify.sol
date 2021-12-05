pragma solidity >0.5.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";


//this contract inherits ERC721
contract NFTify is ERC721Enumerable, ERC721URIStorage {
    uint256 public tokenCounter;

    uint256 public imageCount = 0;
    mapping(uint256 => NFT) public nfts;

    struct NFT {
        uint256 id;
        string hash;
        string description;
    }

    event NFTCreated(
        uint256 id,
        string hash,
        string description
    );

    //constructor for an ERC721 is a name and symbol
    constructor() public ERC721("BlockTops", "SNKZ") {
        tokenCounter = 0;
    }

    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    //a token url is a ipfs url
    //after we mint the token we are going to return the id of the token
    function uploadImage(string memory _imgHash, string memory _description)
        public
        returns (address)
    {
        //get number from token counter
        uint256 newNFTTokenId = tokenCounter;

        //safely mint token for the person that called the function
        _safeMint(msg.sender, newNFTTokenId);
        require(_exists(newNFTTokenId));
        // _mint(msg.sender, newNFTTokenId);

        //set the token uri of the token id of the uri passed
        _setTokenURI(newNFTTokenId, _imgHash);

        //increment the counter
        tokenCounter = tokenCounter + 1;

        emit NFTCreated(newNFTTokenId, _imgHash, _description);

        //return the token id
        return ownerOf(newNFTTokenId);
    }

    function getAllURIs() public view returns (string[] memory) {
        // string[] storage uris;
        uint numTokens = balanceOf(msg.sender);
        string[] memory uris = new string[](numTokens);
        for (uint i = 0; i < numTokens; i++) {
            uint tokenId = tokenOfOwnerByIndex(msg.sender, i);
            uris[i] = (tokenURI(tokenId));
        }
        return uris;
    }

    
}
