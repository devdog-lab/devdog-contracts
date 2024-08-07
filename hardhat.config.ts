import type { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox-viem";
import 'dotenv/config';

const { WALLET_PRIVATE_KEY, SEPOLIA_URL } = process.env;

if (!WALLET_PRIVATE_KEY || !SEPOLIA_URL) {
  throw new Error("Please set your PRIVATE_KEY in a .env file");
}

const config: HardhatUserConfig = {
  solidity: "0.8.24",
  networks: {
    sepolia: {
      url: SEPOLIA_URL,
      accounts: [WALLET_PRIVATE_KEY]
    },
  }
}

export default config;
