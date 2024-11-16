import "@nomicfoundation/hardhat-toolbox";
import { HardhatUserConfig, task } from "hardhat/config";
require("dotenv").config()

const { ALCHEMY_API_URL, PRIVATE_KEY, ETHERSCAN_API_KEY } = process.env

task("accounts", "prints the list ofnaccounts", async (taskArgs, hre) => {

  const accounts = await hre.ethers.getSigners();
  for (const account of accounts) {
    console.log(account.address);
  }
})

task("Voter", "voter contract", async (taskArgs, hre) => {
  const Voter = await hre.ethers.getContractFactory("Voter");
  const voter = await Voter.deploy("A", "B", "C");
  await voter.waitForDeployment();
  console.log('Voter is deployed to address : ', await voter.getAddress());

})
/*  const accounts = await hre.ethers.getSigners();
 for (const account of accounts) {
   console.log(account.address);

   import { createPublicClient, http, Block } from "viem";
import { polygon } from "viem/chains";

const client = createPublicClient({
  chain: polygon,
  transport: http("https://polygon-mainnet.g.alchemy.com/v2/igxfkgPylU0U0icqutfq-KrGD2bELNAL"),
});

const block: Block = await client.getBlock({
  blockNumber: 123456n,
});

console.log(block);
 }
*/
const config: HardhatUserConfig = {
  solidity: {
    version: "0.8.27",
    settings: {
      optimizer: { enabled: true, runs: 200 },
    }, 
  },
  defaultNetwork: "localhost",
  networks: {
    sepolia: {
      url: ALCHEMY_API_URL,
      accounts: [`0x${PRIVATE_KEY}`],
    },
  },
  etherscan: {
    apiKey: ETHERSCAN_API_KEY,
  },
};

export default config;
