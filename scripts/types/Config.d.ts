export interface Config {
    contract: string,
    claimer: string,
    bep20: string,
    networks: Networks
}

export interface Networks {
    bscTestnet: CommonNetwork,
    bscMainnet: CommonNetwork,
    localhost: CommonNetwork,
    hardhat: CommonNetwork
}

export interface CommonNetwork {
    addresses: CommonAddresses
}

export interface CommonAddresses {
    WBNB: string,
    claimer: string,
    contract: string,
    WBTC: string,
    pair: string,
    charity: string,
    router: string,
    factory: string,
    dead: string
}

export interface Deployments {
    bscTestnet: Deployment[],
    bscMainnet: Deployment[],
    localhost: Deployment[],
    hardhat: Deployment[]
}

export interface Deployment {
    time: string,
    contract: string,
    claimer: string,
    pair: string
}