// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ZDAOvote {
    struct Proposta {
        string descricao;
        uint256 votosAFavor;
        uint256 votosContra;
        bool concluida;
        mapping(address => bool) votantes;
    }

    mapping(uint256 => Proposta) public propostas;
    uint256 public idAtual;
    mapping(address => uint256) public tokensGovernanca;
    uint256 public taxaParaProposta = 1;

    constructor() {
        tokensGovernanca[msg.sender] = 100; // Inicializando o criador com 100 tokens
    }

    function criarProposta(string memory descricao) public {
        require(tokensGovernanca[msg.sender] >= taxaParaProposta, "Tokens de governança insuficientes");
        Proposta storage novaProposta = propostas[idAtual];
        novaProposta.descricao = descricao;
        idAtual++;
        tokensGovernanca[msg.sender] -= taxaParaProposta;
    }

    function votar(uint256 id, bool aFavor) public {
        Proposta storage proposta = propostas[id];
        require(!proposta.concluida, "Proposta já concluída");
        require(!proposta.votantes[msg.sender], "Você já votou nesta proposta");

        if (aFavor) {
            proposta.votosAFavor++;
        } else {
            proposta.votosContra++;
        }
        proposta.votantes[msg.sender] = true;
    }

    function finalizarProposta(uint256 id) public {
        Proposta storage proposta = propostas[id];
        require(!proposta.concluida, "Proposta já foi concluída");
        if (proposta.votosAFavor > proposta.votosContra) {
            // Ação da proposta aprovada
            // Ex.: transferir fundos, modificar regras, etc.
        }
        proposta.concluida = true;
    }

    function adicionarTokensGovernanca(address membro, uint256 quantidade) public {
        tokensGovernanca[membro] += quantidade;
    }
}
