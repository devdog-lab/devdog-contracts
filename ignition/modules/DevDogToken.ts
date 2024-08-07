import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";
import { parseEther } from "viem";

const TOTAL_SUPPLY = 1_000_000_000n;

const DevDogModule = buildModule("DevDogModule", (m) => {
  const totalSupply = m.getParameter("totalSupply", TOTAL_SUPPLY);

  const mainContract = m.contract("DevDogToken", [totalSupply]);

  return { mainContract };
});

export default DevDogModule;
