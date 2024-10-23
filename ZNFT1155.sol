// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract ZNFT1155 is ERC1155, Ownable {
    using Strings for uint256;

    // URL base para a imagem do NFT armazenada no Infura
    string public baseURI = "https://ipfs.infura.io/ipfs/{HASH_DA_IMAGEM}";

    // Contador público de horas equivalentes ao NFT
    uint256 public horasEquivalentes = 40;

    // IDs de tokens definidos (podem ser expandidos para múltiplos tipos)
    uint256 public constant NFT_ID = 1;

    constructor() ERC1155(baseURI) {
        // Mint inicial de 1 NFT do tipo NFT_ID para o criador do contrato
        _mint(msg.sender, NFT_ID, 1, "");
    }

    // Função para atualizar o URI da imagem do NFT
    function setBaseURI(string memory newBaseURI) public onlyOwner {
        baseURI = newBaseURI;
    }

    // Função para minting de novos NFTs (até o limite definido de horas equivalentes)
    function mintNFT(address to, uint256 quantidade) public onlyOwner {
        require(quantidade <= horasEquivalentes, "Quantidade excede as horas equivalentes");
        _mint(to, NFT_ID, quantidade, "");
    }

    // Função para retornar o URI do NFT
    function uri(uint256 tokenId) override public view returns (string memory) {
        return string(abi.encodePacked(baseURI, "/", tokenId.toString(), ".json"));
    }

    // Função para ajustar o contador de horas equivalentes
    function setHorasEquivalentes(uint256 novasHoras) public onlyOwner {
        horasEquivalentes = novasHoras;
    }
}
