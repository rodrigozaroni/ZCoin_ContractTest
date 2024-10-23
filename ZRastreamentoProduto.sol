// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ZRastreamentoProduto {
    struct Produto {
        string nome;
        string localizacao;
        uint256 timestamp;
    }

    mapping(uint256 => Produto) public produtos;

    function registrarProduto(uint256 id, string memory nome) public {
        produtos[id] = Produto(nome, "Fábrica", block.timestamp);
    }

    function atualizarLocalizacao(uint256 id, string memory novaLocalizacao) public {
        produtos[id].localizacao = novaLocalizacao;
        produtos[id].timestamp = block.timestamp;
    }

    function obterLocalizacao(uint256 id) public view returns (string memory, uint256) {
        return (produtos[id].localizacao, produtos[id].timestamp);
    }
}
