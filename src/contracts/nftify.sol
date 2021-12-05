pragma solidity >0.5.0;

// import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

// import "@openzeppelin/contracts/utils/Counters.sol";

//this contract inherits ERC721
contract NFTify is ERC721Enumerable {
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
    constructor() public ERC721("astronaut", "STAR") {
        tokenCounter = 0;
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

    function getAllURIs() public returns (string[] memory) {
        string[] uris = new string[];
        uint numTokens = balanceOf(msg.sender);
        for (uint i = 0; i < numTokens; i++) {
            uint tokenId = tokenOfOwnerByIndex(msg.sender, i);
            uris.push(tokenURI(tokenId));
        }
        return uris;
    }

    function _setTokenURI(uint256 tokenId, string memory _tokenURI) internal virtual {
        require(_exists(tokenId), "ERC721URIStorage: URI set of nonexistent token");
        _tokenURIs[tokenId] = _tokenURI;
    }
}
