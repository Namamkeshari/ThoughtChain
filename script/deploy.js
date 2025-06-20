const hre = require("hardhat");

async function main() {
  const ThoughtChain = await hre.ethers.getContractFactory("ThoughtChain");
  const thoughtChain = await ThoughtChain.deploy();

  await thoughtChain.deployed();

  console.log("ThoughtChain deployed to:", thoughtChain.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
