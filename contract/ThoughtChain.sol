// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract ThoughtChain {
    uint256 public thoughtCount;

    struct Thought {
        uint256 id;
        string content;
        address author;
        uint256 timestamp;
    }

    mapping(uint256 => Thought) public thoughts;
    mapping(uint256 => uint256[]) public links; // Link between thoughts

    event ThoughtCreated(uint256 indexed id, address indexed author, string content);
    event ThoughtLinked(uint256 fromId, uint256 toId);

    constructor() {
        thoughtCount = 0;
    }

    function createThought(string calldata _content) external {
        thoughtCount++;
        thoughts[thoughtCount] = Thought(thoughtCount, _content, msg.sender, block.timestamp);
        emit ThoughtCreated(thoughtCount, msg.sender, _content);
    }

    function linkThoughts(uint256 fromId, uint256 toId) external {
        require(thoughts[fromId].author == msg.sender, "Only author can link");
        links[fromId].push(toId);
        emit ThoughtLinked(fromId, toId);
    }

    function getLinkedThoughts(uint256 id) external view returns (uint256[] memory) {
        return links[id];
    }

    function getThought(uint256 id) external view returns (Thought memory) {
        return thoughts[id];
    }
}
