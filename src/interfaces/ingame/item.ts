import { SearchParameters, UuidViewModel } from '@/interfaces/api';

export interface MaterialSearchParameters extends SearchParameters {
    itemCategoryIds?: string | null;
    primaryMaterialIds?: string | null;
}

export interface Material extends UuidViewModel {
    name: string;
    description: string;
    iconUri: string | null;
    itemCategoryId: string;
    wikiUri: string | null;
    mass: number | null;
    corrosionResistance: number | null;
    primaryMaterialId: string | null;
    electricInput: number | null;
    electricOutput: number | null;
    electricityConversionBonusFactor: number | null;
    electricCapacity: number | null;
    propellantInput: number | null;
    propellantOutput: number | null;
    propellantConversionBonusFactor: number | null;
    propellantCapacity: number | null;
    thrustPower: number | null;
    tier: number | null;
    fuelCapacity: number | null;
    fuelInput: number | null;
    heatGeneration: number | null;
    electricityPerShot: number | null;
    electricityPerRecharge: number | null;
    heatGenerationPerShot: number | null;
    heatDissipation: number | null;
    minMuzzleVelocity: number | null;
    maxMuzzleVelocity: number | null;
    rateOfFire: number | null;
    chargeCapacity: number | null;
    magazineCapacity: number | null;
    projectileMass: number | null;
    projectileEnergy: number | null;
    projectileLifetime: number | null;
    researchPointsCube: number | null;
    researchPointsPower: number | null;
    researchPointsShield: number | null;
    researchPointsGear: number | null;
}

export interface CreateMaterial {
    name: string;
    description: string;
    iconUri?: string | null;
    itemCategoryId: string;
    wikiUri?: string | null;
    mass?: number | null;
    corrosionResistance?: number | null;
    primaryMaterialId?: string | null;
    electricInput?: number | null;
    electricOutput?: number | null;
    electricityConversionBonusFactor?: number | null;
    electricCapacity?: number | null;
    propellantInput?: number | null;
    propellantOutput?: number | null;
    propellantConversionBonusFactor?: number | null;
    propellantCapacity?: number | null;
    thrustPower?: number | null;
    tier?: number | null;
    fuelCapacity?: number | null;
    fuelInput?: number | null;
    heatGeneration?: number | null;
    electricityPerShot?: number | null;
    electricityPerRecharge?: number | null;
    heatGenerationPerShot?: number | null;
    heatDissipation?: number | null;
    minMuzzleVelocity?: number | null;
    maxMuzzleVelocity?: number | null;
    rateOfFire?: number | null;
    chargeCapacity?: number | null;
    magazineCapacity?: number | null;
    projectileMass?: number | null;
    projectileEnergy?: number | null;
    projectileLifetime?: number | null;
    researchPointsCube?: number | null;
    researchPointsPower?: number | null;
    researchPointsShield?: number | null;
    researchPointsGear?: number | null;
}

export interface PatchMaterial {
    name?: string;
    description?: string;
    iconUri?: string | null;
    itemCategoryId?: string;
    wikiUri?: string | null;
    mass?: number | null;
    corrosionResistance?: number | null;
    primaryMaterialId?: string | null;
    electricInput?: number | null;
    electricOutput?: number | null;
    electricityConversionBonusFactor?: number | null;
    electricCapacity?: number | null;
    propellantInput?: number | null;
    propellantOutput?: number | null;
    propellantConversionBonusFactor?: number | null;
    propellantCapacity?: number | null;
    thrustPower?: number | null;
    tier?: number | null;
    fuelCapacity?: number | null;
    fuelInput?: number | null;
    heatGeneration?: number | null;
    electricityPerShot?: number | null;
    electricityPerRecharge?: number | null;
    heatGenerationPerShot?: number | null;
    heatDissipation?: number | null;
    minMuzzleVelocity?: number | null;
    maxMuzzleVelocity?: number | null;
    rateOfFire?: number | null;
    chargeCapacity?: number | null;
    magazineCapacity?: number | null;
    projectileMass?: number | null;
    projectileEnergy?: number | null;
    projectileLifetime?: number | null;
    researchPointsCube?: number | null;
    researchPointsPower?: number | null;
    researchPointsShield?: number | null;
    researchPointsGear?: number | null;
}
