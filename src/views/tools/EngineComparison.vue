<template>
<div class="home">
    <LoadingIndicatorBeam v-if="isLoading" />
    <div class="padding-container">
        <Panel>
            <div class="x-scroll">
                <DataTable v-if="this.rawItems.length > 0">
                    <DataTableRow>
                        <DataTableCell></DataTableCell>
                        <DataTableCell>
                            <img class="full-width" :src="items.maneuver.tier1.iconUri" />
                        </DataTableCell>
                        <DataTableCell>
                            <img class="full-width" :src="items.maneuver.tier2.iconUri" />
                        </DataTableCell>
                        <DataTableCell>
                            <img class="full-width" :src="items.maneuver.tier3.iconUri" />
                        </DataTableCell>
                        <DataTableCell>
                            <img class="full-width" :src="items.triangle.tier1.body.iconUri" />
                        </DataTableCell>
                        <DataTableCell>
                            <img class="full-width" :src="items.triangle.tier2.body.iconUri" />
                        </DataTableCell>
                        <DataTableCell>
                            <img class="full-width" :src="items.triangle.tier3.body.iconUri" />
                        </DataTableCell>
                        <DataTableCell>
                            <img class="full-width" :src="items.box.tier1.body.iconUri" />
                        </DataTableCell>
                        <DataTableCell>
                            <img class="full-width" :src="items.box.tier2.body.iconUri" />
                        </DataTableCell>
                        <DataTableCell>
                            <img class="full-width" :src="items.box.tier3.body.iconUri" />
                        </DataTableCell>
                        <DataTableCell>
                            <img class="full-width" src="https://wiki.starbasegame.com/images/c/c6/Starbase_plasma_thruster.png" />
                        </DataTableCell>
                    </DataTableRow>
                    <tr data-augmented-ui="tl-clip tr-clip br-clip bl-clip border">
                        <DataTableCell></DataTableCell>
                        <DataTableCell class="text--center">Maneuver</DataTableCell>
                        <DataTableCell class="text--center">Maneuver</DataTableCell>
                        <DataTableCell class="text--center">Maneuver</DataTableCell>
                        <DataTableCell class="text--center">Triangle</DataTableCell>
                        <DataTableCell class="text--center">Triangle</DataTableCell>
                        <DataTableCell class="text--center">Triangle</DataTableCell>
                        <DataTableCell class="text--center">Box</DataTableCell>
                        <DataTableCell class="text--center">Box</DataTableCell>
                        <DataTableCell class="text--center">Box</DataTableCell>
                        <DataTableCell class="text--center">Plasma</DataTableCell>
                    </tr>
                    <DataTableRow>
                        <DataTableCell></DataTableCell>
                        <DataTableCell class="text--center">Tier 1</DataTableCell>
                        <DataTableCell class="text--center">Tier 2</DataTableCell>
                        <DataTableCell class="text--center">Tier 3</DataTableCell>
                        <DataTableCell class="text--center">Tier 1</DataTableCell>
                        <DataTableCell class="text--center">Tier 2</DataTableCell>
                        <DataTableCell class="text--center">Tier 3</DataTableCell>
                        <DataTableCell class="text--center">Tier 1</DataTableCell>
                        <DataTableCell class="text--center">Tier 2</DataTableCell>
                        <DataTableCell class="text--center">Tier 3</DataTableCell>
                        <DataTableCell>
                            <div class="flex flex--center-horizontal">
                                <NumberAdjuster v-model="rings"/>
                            </div>
                        </DataTableCell>
                    </DataTableRow>
                    <DataTableRow>
                        <DataTableCell>{{ $t('mass') }}</DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.maneuver.tier1.mass)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.maneuver.tier2.mass)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.maneuver.tier3.mass)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.triangle.tier1.mass)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.triangle.tier2.mass)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.triangle.tier3.mass)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.box.tier1.mass)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.box.tier2.mass)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.box.tier3.mass)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.plasma.mass)"></DataTableCell>
                    </DataTableRow>
                    <DataTableRow>
                        <DataTableCell>{{ $t('electricInput') }}</DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.maneuver.tier1.electricInput)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.maneuver.tier2.electricInput)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.maneuver.tier3.electricInput)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.triangle.tier1.electricInput)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.triangle.tier2.electricInput)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.triangle.tier3.electricInput)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.box.tier1.electricInput)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.box.tier2.electricInput)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.box.tier3.electricInput)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.plasma.electricInput)"></DataTableCell>
                    </DataTableRow>
                    <DataTableRow>
                        <DataTableCell>{{ $t('electricInput') }} {{ $t('optimized') }}</DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.maneuver.tier1.electricInputOptimized)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.maneuver.tier2.electricInputOptimized)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.maneuver.tier3.electricInputOptimized)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.triangle.tier1.electricInputOptimized)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.triangle.tier2.electricInputOptimized)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.triangle.tier3.electricInputOptimized)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.box.tier1.electricInputOptimized)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.box.tier2.electricInputOptimized)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.box.tier3.electricInputOptimized)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.plasma.electricInputOptimized)"></DataTableCell>
                    </DataTableRow>
                    <DataTableRow>
                        <DataTableCell>{{ $t('propellantInput') }}</DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.maneuver.tier1.propellantInput)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.maneuver.tier2.propellantInput)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.maneuver.tier3.propellantInput)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.triangle.tier1.propellantInput)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.triangle.tier2.propellantInput)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.triangle.tier3.propellantInput)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.box.tier1.propellantInput)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.box.tier2.propellantInput)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.box.tier3.propellantInput)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.plasma.propellantInput)"></DataTableCell>
                    </DataTableRow>
                    <DataTableRow>
                        <DataTableCell>{{ $t('propellantInput') }} {{ $t('optimized') }}</DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.maneuver.tier1.propellantInputOptimized)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.maneuver.tier2.propellantInputOptimized)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.maneuver.tier3.propellantInputOptimized)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.triangle.tier1.propellantInputOptimized)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.triangle.tier2.propellantInputOptimized)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.triangle.tier3.propellantInputOptimized)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.box.tier1.propellantInputOptimized)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.box.tier2.propellantInputOptimized)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.box.tier3.propellantInputOptimized)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.plasma.propellantInputOptimized)"></DataTableCell>
                    </DataTableRow>
                    <DataTableRow>
                        <DataTableCell>{{ $t('thrustPower') }}</DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.maneuver.tier1.thrustPower)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.maneuver.tier2.thrustPower)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.maneuver.tier3.thrustPower)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.triangle.tier1.thrustPower)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.triangle.tier2.thrustPower)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.triangle.tier3.thrustPower)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.box.tier1.thrustPower)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.box.tier2.thrustPower)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.box.tier3.thrustPower)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.plasma.thrustPower)"></DataTableCell>
                    </DataTableRow>
                    <DataTableRow>
                        <DataTableCell>{{ $t('thrustPerElectricity') }}</DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(stats.maneuver.tier1.thrustPerElectricity)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(stats.maneuver.tier2.thrustPerElectricity)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(stats.maneuver.tier3.thrustPerElectricity)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(stats.triangle.tier1.thrustPerElectricity)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(stats.triangle.tier2.thrustPerElectricity)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(stats.triangle.tier3.thrustPerElectricity)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(stats.box.tier1.thrustPerElectricity)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(stats.box.tier2.thrustPerElectricity)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(stats.box.tier3.thrustPerElectricity)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(stats.plasma.thrustPerElectricity)"></DataTableCell>
                    </DataTableRow>
                    <DataTableRow>
                        <DataTableCell>{{ $t('thrustPerPropellant') }}</DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(stats.maneuver.tier1.thrustPerPropellant)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(stats.maneuver.tier2.thrustPerPropellant)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(stats.maneuver.tier3.thrustPerPropellant)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(stats.triangle.tier1.thrustPerPropellant)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(stats.triangle.tier2.thrustPerPropellant)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(stats.triangle.tier3.thrustPerPropellant)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(stats.box.tier1.thrustPerPropellant)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(stats.box.tier2.thrustPerPropellant)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(stats.box.tier3.thrustPerPropellant)"></DataTableCell>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(stats.plasma.thrustPerPropellant)"></DataTableCell>
                    </DataTableRow>
                    <DataTableRow>
                        <DataTableCell>{{ $t('smallPropellantTankDepletionTime') }}</DataTableCell>
                        <DataTableCell class="text--right"><DurationFormatter :seconds="stats.maneuver.tier1.propellantTankDeplectionTime.small"/></DataTableCell>
                        <DataTableCell class="text--right"><DurationFormatter :seconds="stats.maneuver.tier2.propellantTankDeplectionTime.small"/></DataTableCell>
                        <DataTableCell class="text--right"><DurationFormatter :seconds="stats.maneuver.tier3.propellantTankDeplectionTime.small"/></DataTableCell>
                        <DataTableCell class="text--right"><DurationFormatter :seconds="stats.triangle.tier1.propellantTankDeplectionTime.small"/></DataTableCell>
                        <DataTableCell class="text--right"><DurationFormatter :seconds="stats.triangle.tier2.propellantTankDeplectionTime.small"/></DataTableCell>
                        <DataTableCell class="text--right"><DurationFormatter :seconds="stats.triangle.tier3.propellantTankDeplectionTime.small"/></DataTableCell>
                        <DataTableCell class="text--right"><DurationFormatter :seconds="stats.box.tier1.propellantTankDeplectionTime.small"/></DataTableCell>
                        <DataTableCell class="text--right"><DurationFormatter :seconds="stats.box.tier2.propellantTankDeplectionTime.small"/></DataTableCell>
                        <DataTableCell class="text--right"><DurationFormatter :seconds="stats.box.tier3.propellantTankDeplectionTime.small"/></DataTableCell>
                        <DataTableCell class="text--right"><DurationFormatter :seconds="stats.plasma.propellantTankDeplectionTime.small"/></DataTableCell>
                    </DataTableRow>
                    <DataTableRow>
                        <DataTableCell>{{ $t('mediumPropellantTankDepletionTime') }}</DataTableCell>
                        <DataTableCell class="text--right"><DurationFormatter :seconds="stats.maneuver.tier1.propellantTankDeplectionTime.medium"/></DataTableCell>
                        <DataTableCell class="text--right"><DurationFormatter :seconds="stats.maneuver.tier2.propellantTankDeplectionTime.medium"/></DataTableCell>
                        <DataTableCell class="text--right"><DurationFormatter :seconds="stats.maneuver.tier3.propellantTankDeplectionTime.medium"/></DataTableCell>
                        <DataTableCell class="text--right"><DurationFormatter :seconds="stats.triangle.tier1.propellantTankDeplectionTime.medium"/></DataTableCell>
                        <DataTableCell class="text--right"><DurationFormatter :seconds="stats.triangle.tier2.propellantTankDeplectionTime.medium"/></DataTableCell>
                        <DataTableCell class="text--right"><DurationFormatter :seconds="stats.triangle.tier3.propellantTankDeplectionTime.medium"/></DataTableCell>
                        <DataTableCell class="text--right"><DurationFormatter :seconds="stats.box.tier1.propellantTankDeplectionTime.medium"/></DataTableCell>
                        <DataTableCell class="text--right"><DurationFormatter :seconds="stats.box.tier2.propellantTankDeplectionTime.medium"/></DataTableCell>
                        <DataTableCell class="text--right"><DurationFormatter :seconds="stats.box.tier3.propellantTankDeplectionTime.medium"/></DataTableCell>
                        <DataTableCell class="text--right"><DurationFormatter :seconds="stats.plasma.propellantTankDeplectionTime.medium"/></DataTableCell>
                    </DataTableRow>
                    <DataTableRow>
                        <DataTableCell>{{ $t('largePropellantTankDepletionTime') }}</DataTableCell>
                        <DataTableCell class="text--right"><DurationFormatter :seconds="stats.maneuver.tier1.propellantTankDeplectionTime.large"/></DataTableCell>
                        <DataTableCell class="text--right"><DurationFormatter :seconds="stats.maneuver.tier2.propellantTankDeplectionTime.large"/></DataTableCell>
                        <DataTableCell class="text--right"><DurationFormatter :seconds="stats.maneuver.tier3.propellantTankDeplectionTime.large"/></DataTableCell>
                        <DataTableCell class="text--right"><DurationFormatter :seconds="stats.triangle.tier1.propellantTankDeplectionTime.large"/></DataTableCell>
                        <DataTableCell class="text--right"><DurationFormatter :seconds="stats.triangle.tier2.propellantTankDeplectionTime.large"/></DataTableCell>
                        <DataTableCell class="text--right"><DurationFormatter :seconds="stats.triangle.tier3.propellantTankDeplectionTime.large"/></DataTableCell>
                        <DataTableCell class="text--right"><DurationFormatter :seconds="stats.box.tier1.propellantTankDeplectionTime.large"/></DataTableCell>
                        <DataTableCell class="text--right"><DurationFormatter :seconds="stats.box.tier2.propellantTankDeplectionTime.large"/></DataTableCell>
                        <DataTableCell class="text--right"><DurationFormatter :seconds="stats.box.tier3.propellantTankDeplectionTime.large"/></DataTableCell>
                        <DataTableCell class="text--right"><DurationFormatter :seconds="stats.plasma.propellantTankDeplectionTime.large"/></DataTableCell>
                    </DataTableRow>
                </DataTable>
            </div>
        </Panel>
    </div>
</div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import Panel from '@/components/layout/Panel.vue';
import ViewMixin from '@/mixins/ViewMixin';
import * as itemService from '@/services/ingame/itemService';
import { Item } from '@/interfaces/ingame/item';
import LoadingIndicatorBeam from '@/components/loading/LoadingIndicatorBeam.vue';
import NumberAdjuster from '@/components/controls/NumberAdjuster.vue';
import { numberToLocaleString } from '@/helpers';
import DurationFormatter from '@/components/formatters/DurationFormatter.vue';
import DataTable from '@/components/layout/dataTable/DataTable.vue';
import DataTableRow from '@/components/layout/dataTable/DataTableRow.vue';
import DataTableCell from '@/components/layout/dataTable/DataTableCell.vue';

interface Data {
    isLoading: boolean;
    rawItems: Item[];
    rings: number;
}

// eslint-disable-next-line @typescript-eslint/no-unused-vars

interface Items {
    maneuver: {
        tier1: Item;
        tier2: Item;
        tier3: Item;
    },
    electricityConverter: {
        tier1: Item;
        tier2: Item;
        tier3: Item;
    },
    propellantConverter: {
        tier1: Item;
        tier2: Item;
        tier3: Item;
    },
    box: {
        combustionChamber: Item;
        tier1: {
            body: Item;
            nozzle: Item;
        },
        tier2: {
            body: Item;
            nozzle: Item;
        },
        tier3: {
            body: Item;
            nozzle: Item;
        },
    },
    triangle: {
        combustionChamber: Item;
        tier1: {
            body: Item;
            nozzle: Item;
        },
        tier2: {
            body: Item;
            nozzle: Item;
        },
        tier3: {
            body: Item;
            nozzle: Item;
        },
    },
    plasma: {
        capacitor: Item;
        capacitorStruct: Item;
        core: Item;
        engine: Item;
        frame: Item;
        nozzle: Item;
        collar: Item;
        superconductor: Item;
        superconductorStruct: Item;
    },
    propellantTanks: {
        small: Item;
        medium: Item;
        large: Item;
    }
}

function calcOptimizedInput(input: number, bonus: number): number {
    return input - (input * bonus);
}

export default defineComponent({
    name: 'EngineComparison',
    components: {
        DataTable,
        DataTableRow,
        DataTableCell,
        DurationFormatter,
        LoadingIndicatorBeam,
        NumberAdjuster,
        Panel,
    },
    mixins: [ViewMixin],
    data: (): Data => ({
        isLoading: false,
        rawItems: [],
        rings: 0,
    }),
    computed: {
        stats() {
            return {
                maneuver: {
                    tier1: {
                        thrustPerElectricity: this.calculated.maneuver.tier1.thrustPower / this.calculated.maneuver.tier1.electricInput,
                        thrustPerPropellant: this.calculated.maneuver.tier1.thrustPower / this.calculated.maneuver.tier1.propellantInput,
                        propellantTankDeplectionTime: {
                            small: (this.items.propellantTanks.small.propellantCapacity as number) / this.calculated.maneuver.tier1.propellantInput,
                            medium: (this.items.propellantTanks.medium.propellantCapacity as number) / this.calculated.maneuver.tier1.propellantInput,
                            large: (this.items.propellantTanks.large.propellantCapacity as number) / this.calculated.maneuver.tier1.propellantInput,
                        },
                    },
                    tier2: {
                        thrustPerElectricity: this.calculated.maneuver.tier2.thrustPower / this.calculated.maneuver.tier2.electricInput,
                        thrustPerPropellant: this.calculated.maneuver.tier2.thrustPower / this.calculated.maneuver.tier2.propellantInput,
                        propellantTankDeplectionTime: {
                            small: (this.items.propellantTanks.small.propellantCapacity as number) / this.calculated.maneuver.tier2.propellantInput,
                            medium: (this.items.propellantTanks.medium.propellantCapacity as number) / this.calculated.maneuver.tier2.propellantInput,
                            large: (this.items.propellantTanks.large.propellantCapacity as number) / this.calculated.maneuver.tier2.propellantInput,
                        },
                    },
                    tier3: {
                        thrustPerElectricity: this.calculated.maneuver.tier3.thrustPower / this.calculated.maneuver.tier3.electricInput,
                        thrustPerPropellant: this.calculated.maneuver.tier3.thrustPower / this.calculated.maneuver.tier3.propellantInput,
                        propellantTankDeplectionTime: {
                            small: (this.items.propellantTanks.small.propellantCapacity as number) / this.calculated.maneuver.tier3.propellantInput,
                            medium: (this.items.propellantTanks.medium.propellantCapacity as number) / this.calculated.maneuver.tier3.propellantInput,
                            large: (this.items.propellantTanks.large.propellantCapacity as number) / this.calculated.maneuver.tier3.propellantInput,
                        },
                    },
                },
                triangle: {
                    tier1: {
                        thrustPerElectricity: this.calculated.triangle.tier1.thrustPower / this.calculated.triangle.tier1.electricInput,
                        thrustPerPropellant: this.calculated.triangle.tier1.thrustPower / this.calculated.triangle.tier1.propellantInput,
                        propellantTankDeplectionTime: {
                            small: (this.items.propellantTanks.small.propellantCapacity as number) / this.calculated.triangle.tier1.propellantInput,
                            medium: (this.items.propellantTanks.medium.propellantCapacity as number) / this.calculated.triangle.tier1.propellantInput,
                            large: (this.items.propellantTanks.large.propellantCapacity as number) / this.calculated.triangle.tier1.propellantInput,
                        },
                    },
                    tier2: {
                        thrustPerElectricity: this.calculated.triangle.tier2.thrustPower / this.calculated.triangle.tier2.electricInput,
                        thrustPerPropellant: this.calculated.triangle.tier2.thrustPower / this.calculated.triangle.tier2.propellantInput,
                        propellantTankDeplectionTime: {
                            small: (this.items.propellantTanks.small.propellantCapacity as number) / this.calculated.triangle.tier2.propellantInput,
                            medium: (this.items.propellantTanks.medium.propellantCapacity as number) / this.calculated.triangle.tier2.propellantInput,
                            large: (this.items.propellantTanks.large.propellantCapacity as number) / this.calculated.triangle.tier2.propellantInput,
                        },
                    },
                    tier3: {
                        thrustPerElectricity: this.calculated.triangle.tier3.thrustPower / this.calculated.triangle.tier3.electricInput,
                        thrustPerPropellant: this.calculated.triangle.tier3.thrustPower / this.calculated.triangle.tier3.propellantInput,
                        propellantTankDeplectionTime: {
                            small: (this.items.propellantTanks.small.propellantCapacity as number) / this.calculated.triangle.tier3.propellantInput,
                            medium: (this.items.propellantTanks.medium.propellantCapacity as number) / this.calculated.triangle.tier3.propellantInput,
                            large: (this.items.propellantTanks.large.propellantCapacity as number) / this.calculated.triangle.tier3.propellantInput,
                        },
                    },
                },
                box: {
                    tier1: {
                        thrustPerElectricity: this.calculated.box.tier1.thrustPower / this.calculated.box.tier1.electricInput,
                        thrustPerPropellant: this.calculated.box.tier1.thrustPower / this.calculated.box.tier1.propellantInput,
                        propellantTankDeplectionTime: {
                            small: (this.items.propellantTanks.small.propellantCapacity as number) / this.calculated.box.tier1.propellantInput,
                            medium: (this.items.propellantTanks.medium.propellantCapacity as number) / this.calculated.box.tier1.propellantInput,
                            large: (this.items.propellantTanks.large.propellantCapacity as number) / this.calculated.box.tier1.propellantInput,
                        },
                    },
                    tier2: {
                        thrustPerElectricity: this.calculated.box.tier2.thrustPower / this.calculated.box.tier2.electricInput,
                        thrustPerPropellant: this.calculated.box.tier2.thrustPower / this.calculated.box.tier2.propellantInput,
                        propellantTankDeplectionTime: {
                            small: (this.items.propellantTanks.small.propellantCapacity as number) / this.calculated.box.tier2.propellantInput,
                            medium: (this.items.propellantTanks.medium.propellantCapacity as number) / this.calculated.box.tier2.propellantInput,
                            large: (this.items.propellantTanks.large.propellantCapacity as number) / this.calculated.box.tier2.propellantInput,
                        },
                    },
                    tier3: {
                        thrustPerElectricity: this.calculated.box.tier3.thrustPower / this.calculated.box.tier3.electricInput,
                        thrustPerPropellant: this.calculated.box.tier3.thrustPower / this.calculated.box.tier3.propellantInput,
                        propellantTankDeplectionTime: {
                            small: (this.items.propellantTanks.small.propellantCapacity as number) / this.calculated.box.tier3.propellantInput,
                            medium: (this.items.propellantTanks.medium.propellantCapacity as number) / this.calculated.box.tier3.propellantInput,
                            large: (this.items.propellantTanks.large.propellantCapacity as number) / this.calculated.box.tier3.propellantInput,
                        },
                    },
                },
                plasma: {
                    thrustPerElectricity: this.calculated.plasma.thrustPower / this.calculated.plasma.electricInput,
                    thrustPerPropellant: this.calculated.plasma.thrustPower / this.calculated.plasma.propellantInput,
                    propellantTankDeplectionTime: {
                        small: (this.items.propellantTanks.small.propellantCapacity as number) / this.calculated.plasma.propellantInput,
                        medium: (this.items.propellantTanks.medium.propellantCapacity as number) / this.calculated.plasma.propellantInput,
                        large: (this.items.propellantTanks.large.propellantCapacity as number) / this.calculated.plasma.propellantInput,
                    },
                },
            };
        },
        calculated() {
            return {
                maneuver: {
                    tier1: {
                        mass: (this.items.maneuver.tier1.mass as number),
                        electricInput: (this.items.maneuver.tier1.electricInput as number),
                        propellantInput: (this.items.maneuver.tier1.propellantInput as number),
                        thrustPower: (this.items.maneuver.tier1.thrustPower as number),
                    },
                    tier2: {
                        mass: (this.items.maneuver.tier2.mass as number),
                        electricInput: (this.items.maneuver.tier2.electricInput as number),
                        propellantInput: (this.items.maneuver.tier2.propellantInput as number),
                        thrustPower: (this.items.maneuver.tier2.thrustPower as number),
                    },
                    tier3: {
                        mass: (this.items.maneuver.tier3.mass as number),
                        electricInput: (this.items.maneuver.tier3.electricInput as number),
                        propellantInput: (this.items.maneuver.tier3.propellantInput as number),
                        thrustPower: (this.items.maneuver.tier3.thrustPower as number),
                    },
                },
                triangle: {
                    tier1: {
                        mass: (this.items.propellantConverter.tier1.mass as number) + (this.items.electricityConverter.tier1.mass as number) + (this.items.triangle.combustionChamber.mass as number) + (this.items.triangle.tier1.body.mass as number) + (this.items.triangle.tier1.nozzle.mass as number),

                        electricInput:
                            (this.items.triangle.combustionChamber.electricInput as number)
                            + (this.items.triangle.tier1.body.electricInput as number)
                            + (this.items.triangle.tier1.nozzle.electricInput as number),

                        electricInputOptimized:
                            calcOptimizedInput(
                                (this.items.triangle.combustionChamber.electricInput as number)
                                + (this.items.triangle.tier1.body.electricInput as number)
                                + (this.items.triangle.tier1.nozzle.electricInput as number),
                                this.items.electricityConverter.tier1.electricityConversionBonusFactor as number,
                            ),

                        propellantInput:
                            (this.items.triangle.combustionChamber.propellantInput as number)
                            + (this.items.triangle.tier1.body.propellantInput as number)
                            + (this.items.triangle.tier1.nozzle.propellantInput as number),

                        propellantInputOptimized:
                            calcOptimizedInput(
                                (this.items.triangle.combustionChamber.propellantInput as number)
                                + (this.items.triangle.tier1.body.propellantInput as number)
                                + (this.items.triangle.tier1.nozzle.propellantInput as number),
                                this.items.propellantConverter.tier1.propellantConversionBonusFactor as number,
                            ),

                        thrustPower:
                            (this.items.triangle.combustionChamber.thrustPower as number)
                            + (this.items.triangle.tier1.body.thrustPower as number)
                            + (this.items.triangle.tier1.nozzle.thrustPower as number),
                    },
                    tier2: {
                        mass: (this.items.propellantConverter.tier2.mass as number) + (this.items.electricityConverter.tier2.mass as number) + (this.items.triangle.combustionChamber.mass as number) + (this.items.triangle.tier2.body.mass as number) + (this.items.triangle.tier2.nozzle.mass as number),

                        electricInput:
                            (this.items.triangle.combustionChamber.electricInput as number)
                            + (this.items.triangle.tier2.body.electricInput as number)
                            + (this.items.triangle.tier2.nozzle.electricInput as number),

                        electricInputOptimized:
                            calcOptimizedInput(
                                (this.items.triangle.combustionChamber.electricInput as number)
                                + (this.items.triangle.tier2.body.electricInput as number)
                                + (this.items.triangle.tier2.nozzle.electricInput as number),
                                this.items.electricityConverter.tier2.electricityConversionBonusFactor as number,
                            ),

                        propellantInput:
                            (this.items.triangle.combustionChamber.propellantInput as number)
                            + (this.items.triangle.tier2.body.propellantInput as number)
                            + (this.items.triangle.tier2.nozzle.propellantInput as number),

                        propellantInputOptimized:
                            calcOptimizedInput(
                                (this.items.triangle.combustionChamber.propellantInput as number)
                                + (this.items.triangle.tier2.body.propellantInput as number)
                                + (this.items.triangle.tier2.nozzle.propellantInput as number),
                                this.items.propellantConverter.tier2.propellantConversionBonusFactor as number,
                            ),

                        thrustPower:
                            (this.items.triangle.combustionChamber.thrustPower as number)
                            + (this.items.triangle.tier2.body.thrustPower as number)
                            + (this.items.triangle.tier2.nozzle.thrustPower as number),
                    },
                    tier3: {
                        mass: (this.items.propellantConverter.tier3.mass as number) + (this.items.electricityConverter.tier2.mass as number) + (this.items.triangle.combustionChamber.mass as number) + (this.items.triangle.tier3.body.mass as number) + (this.items.triangle.tier3.nozzle.mass as number),

                        electricInput:
                            (this.items.triangle.combustionChamber.electricInput as number)
                            + (this.items.triangle.tier3.body.electricInput as number)
                            + (this.items.triangle.tier3.nozzle.electricInput as number),

                        electricInputOptimized:
                            calcOptimizedInput(
                                (this.items.triangle.combustionChamber.electricInput as number)
                                + (this.items.triangle.tier3.body.electricInput as number)
                                + (this.items.triangle.tier3.nozzle.electricInput as number),
                                this.items.electricityConverter.tier3.electricityConversionBonusFactor as number,
                            ),

                        propellantInput:
                            (this.items.triangle.combustionChamber.propellantInput as number)
                            + (this.items.triangle.tier3.body.propellantInput as number)
                            + (this.items.triangle.tier3.nozzle.propellantInput as number),

                        propellantInputOptimized:
                            calcOptimizedInput(
                                (this.items.triangle.combustionChamber.propellantInput as number)
                                + (this.items.triangle.tier3.body.propellantInput as number)
                                + (this.items.triangle.tier3.nozzle.propellantInput as number),
                                this.items.propellantConverter.tier3.propellantConversionBonusFactor as number,
                            ),

                        thrustPower:
                            (this.items.triangle.combustionChamber.thrustPower as number)
                            + (this.items.triangle.tier3.body.thrustPower as number)
                            + (this.items.triangle.tier3.nozzle.thrustPower as number),
                    },
                },
                box: {
                    tier1: {
                        mass: (this.items.propellantConverter.tier1.mass as number) + (this.items.electricityConverter.tier1.mass as number) + (this.items.box.combustionChamber.mass as number) + (this.items.box.tier1.body.mass as number) + (this.items.box.tier1.nozzle.mass as number),

                        electricInput:
                            (this.items.box.combustionChamber.electricInput as number)
                            + (this.items.box.tier1.body.electricInput as number)
                            + (this.items.box.tier1.nozzle.electricInput as number),

                        electricInputOptimized:
                            calcOptimizedInput(
                                (this.items.box.combustionChamber.electricInput as number)
                                + (this.items.box.tier1.body.electricInput as number)
                                + (this.items.box.tier1.nozzle.electricInput as number),
                                this.items.electricityConverter.tier1.electricityConversionBonusFactor as number,
                            ),

                        propellantInput:
                            (this.items.box.combustionChamber.propellantInput as number)
                            + (this.items.box.tier1.body.propellantInput as number)
                            + (this.items.box.tier1.nozzle.propellantInput as number),

                        propellantInputOptimized:
                            calcOptimizedInput(
                                (this.items.box.combustionChamber.propellantInput as number)
                                + (this.items.box.tier1.body.propellantInput as number)
                                + (this.items.box.tier1.nozzle.propellantInput as number),
                                this.items.propellantConverter.tier1.propellantConversionBonusFactor as number,
                            ),

                        thrustPower:
                            (this.items.box.combustionChamber.thrustPower as number)
                            + (this.items.box.tier1.body.thrustPower as number)
                            + (this.items.box.tier1.nozzle.thrustPower as number),
                    },
                    tier2: {
                        mass: (this.items.propellantConverter.tier2.mass as number) + (this.items.electricityConverter.tier2.mass as number) + (this.items.box.combustionChamber.mass as number) + (this.items.box.tier2.body.mass as number) + (this.items.box.tier2.nozzle.mass as number),

                        electricInput:
                            (this.items.box.combustionChamber.electricInput as number)
                            + (this.items.box.tier2.body.electricInput as number)
                            + (this.items.box.tier2.nozzle.electricInput as number),

                        electricInputOptimized:
                            calcOptimizedInput(
                                (this.items.box.combustionChamber.electricInput as number)
                                + (this.items.box.tier2.body.electricInput as number)
                                + (this.items.box.tier2.nozzle.electricInput as number),
                                this.items.electricityConverter.tier2.electricityConversionBonusFactor as number,
                            ),

                        propellantInput:
                            (this.items.box.combustionChamber.propellantInput as number)
                            + (this.items.box.tier2.body.propellantInput as number)
                            + (this.items.box.tier2.nozzle.propellantInput as number),

                        propellantInputOptimized:
                            calcOptimizedInput(
                                (this.items.box.combustionChamber.propellantInput as number)
                                + (this.items.box.tier2.body.propellantInput as number)
                                + (this.items.box.tier2.nozzle.propellantInput as number),
                                this.items.propellantConverter.tier2.propellantConversionBonusFactor as number,
                            ),

                        thrustPower:
                            (this.items.box.combustionChamber.thrustPower as number)
                            + (this.items.box.tier2.body.thrustPower as number)
                            + (this.items.box.tier2.nozzle.thrustPower as number),
                    },
                    tier3: {
                        mass: (this.items.propellantConverter.tier3.mass as number) + (this.items.electricityConverter.tier2.mass as number) + (this.items.box.combustionChamber.mass as number) + (this.items.box.tier3.body.mass as number) + (this.items.box.tier3.nozzle.mass as number),

                        electricInput:
                            (this.items.box.combustionChamber.electricInput as number)
                            + (this.items.box.tier3.body.electricInput as number)
                            + (this.items.box.tier3.nozzle.electricInput as number),

                        electricInputOptimized:
                            calcOptimizedInput(
                                (this.items.box.combustionChamber.electricInput as number)
                                + (this.items.box.tier3.body.electricInput as number)
                                + (this.items.box.tier3.nozzle.electricInput as number),
                                this.items.electricityConverter.tier3.electricityConversionBonusFactor as number,
                            ),

                        propellantInput:
                            (this.items.box.combustionChamber.propellantInput as number)
                            + (this.items.box.tier3.body.propellantInput as number)
                            + (this.items.box.tier3.nozzle.propellantInput as number),

                        propellantInputOptimized:
                            calcOptimizedInput(
                                (this.items.box.combustionChamber.propellantInput as number)
                                + (this.items.box.tier3.body.propellantInput as number)
                                + (this.items.box.tier3.nozzle.propellantInput as number),
                                this.items.propellantConverter.tier3.propellantConversionBonusFactor as number,
                            ),

                        thrustPower:
                            (this.items.box.combustionChamber.thrustPower as number)
                            + (this.items.box.tier3.body.thrustPower as number)
                            + (this.items.box.tier3.nozzle.thrustPower as number),
                    },
                },
                plasma: {
                    mass:
                        ((this.items.plasma.capacitor.mass as number) * 4)
                        + ((this.items.plasma.capacitorStruct.mass as number) * 2)
                        + (this.items.plasma.core.mass as number)
                        + ((this.items.plasma.engine.mass as number) * 4)
                        + ((this.items.plasma.frame.mass as number) * 4)
                        + ((this.items.plasma.collar.mass as number) * 2)
                        + (((this.items.plasma.superconductor.mass as number) * 4) * this.rings)
                        + ((this.items.plasma.nozzle.mass as number) * 2),

                    electricInput:
                        calcOptimizedInput(
                            ((this.items.plasma.nozzle.electricInput as number) * 2)
                            + (((this.items.plasma.superconductor.electricInput as number) * 4) * this.rings),
                            ((this.items.plasma.frame.electricityConversionBonusFactor as number) * 4),
                        ),

                    propellantInput:
                        calcOptimizedInput(
                            ((this.items.plasma.nozzle.propellantInput as number) * 2)
                            + (((this.items.plasma.superconductor.propellantInput as number) * 4) * this.rings),
                            ((this.items.plasma.engine.propellantConversionBonusFactor as number) * 4),
                        ),

                    thrustPower:
                        ((this.items.plasma.nozzle.thrustPower as number) * 2)
                        + (((this.items.plasma.superconductor.thrustPower as number) * 4) * this.rings),
                },
            };
        },
        items(): Items {
            return {
                maneuver: {
                    tier1: this.rawItems.find(({ id }) => id === '08d96f2c-a9cd-4bbb-8e4b-ec491767bfcc') as Item,
                    tier2: this.rawItems.find(({ id }) => id === '08d96f2c-e100-486f-856d-df06722a39aa') as Item,
                    tier3: this.rawItems.find(({ id }) => id === '08d96f2d-1162-4cca-824d-5d5a11c4efab') as Item,
                },
                electricityConverter: {
                    tier1: this.rawItems.find(({ id }) => id === '08d96f36-a6eb-4c63-844e-8c554416a160') as Item,
                    tier2: this.rawItems.find(({ id }) => id === '08d96f36-d62a-410e-8e0c-4acb4127b6a3') as Item,
                    tier3: this.rawItems.find(({ id }) => id === '08d96f36-fe3d-46ee-8dcb-108b554eeefc') as Item,
                },
                propellantConverter: {
                    tier1: this.rawItems.find(({ id }) => id === '08d96f37-2e2e-48d1-8ea8-a9b837e085bb') as Item,
                    tier2: this.rawItems.find(({ id }) => id === '08d96f37-52af-4b34-8427-1f3e7e59f52e') as Item,
                    tier3: this.rawItems.find(({ id }) => id === '08d96f37-9104-47ac-825a-2ecf111bdb11') as Item,
                },
                box: {
                    combustionChamber: this.rawItems.find(({ id }) => id === '08d96f1c-b732-4f6e-8f90-4d64ff491831') as Item,
                    tier1: {
                        body: this.rawItems.find(({ id }) => id === '08d96f1c-3ffb-4fbf-8194-c72a95de75e4') as Item,
                        nozzle: this.rawItems.find(({ id }) => id === '08d96f1d-01bc-4d79-821f-a057f6ac3168') as Item,
                    },
                    tier2: {
                        body: this.rawItems.find(({ id }) => id === '08d96f1c-5fb9-4913-8385-b44e74d80a29') as Item,
                        nozzle: this.rawItems.find(({ id }) => id === '08d96f1d-1abc-4a82-85c7-dc14b01172de') as Item,
                    },
                    tier3: {
                        body: this.rawItems.find(({ id }) => id === '08d96f1c-919e-4adf-853f-8d4346dd5f6d') as Item,
                        nozzle: this.rawItems.find(({ id }) => id === '08d96f1d-3570-4d5f-8671-a075c3e0ea1f') as Item,
                    },
                },
                triangle: {
                    combustionChamber: this.rawItems.find(({ id }) => id === '08d96f39-090e-42bd-8977-08fce61966af') as Item,
                    tier1: {
                        body: this.rawItems.find(({ id }) => id === '08d96f37-dd8e-4f16-8d59-bd006f2a22ef') as Item,
                        nozzle: this.rawItems.find(({ id }) => id === '08d96f39-31c0-4ce2-8b25-764e853fc422') as Item,
                    },
                    tier2: {
                        body: this.rawItems.find(({ id }) => id === '08d96f38-22ec-44d9-88d3-2731aeec164e') as Item,
                        nozzle: this.rawItems.find(({ id }) => id === '08d96f39-8f2f-4959-894f-a4eef5143dc1') as Item,
                    },
                    tier3: {
                        body: this.rawItems.find(({ id }) => id === '08d96f38-5d4b-45bb-8aef-e7898082c1db') as Item,
                        nozzle: this.rawItems.find(({ id }) => id === '08d96f39-b408-436d-821d-31956569f1a5') as Item,
                    },
                },
                plasma: {
                    capacitor: this.rawItems.find(({ id }) => id === '08d96f30-a825-45fc-86d1-3c79fdaed555') as Item,
                    capacitorStruct: this.rawItems.find(({ id }) => id === '08d96f31-2678-4372-8045-5c2c08b469cc') as Item,
                    core: this.rawItems.find(({ id }) => id === '08d96f31-66ae-4170-8a04-6a91dfcae13d') as Item,
                    engine: this.rawItems.find(({ id }) => id === '08d96f32-0564-44f7-803e-e6eb052427f9') as Item,
                    frame: this.rawItems.find(({ id }) => id === '08d96f32-c776-44f9-8dda-7a4e1b164fda') as Item,
                    nozzle: this.rawItems.find(({ id }) => id === '08d96f33-263b-4e64-883f-ad9622d885c4') as Item,
                    collar: this.rawItems.find(({ id }) => id === '08d96f33-749e-4c6c-8989-0ae5218023bc') as Item,
                    superconductor: this.rawItems.find(({ id }) => id === '08d96f33-adf3-49a0-8c79-854df1d90889') as Item,
                    superconductorStruct: this.rawItems.find(({ id }) => id === '08d96f33-d769-45ef-8269-76fcb782118b') as Item,
                },
                propellantTanks: {
                    small: this.rawItems.find(({ id }) => id === '08d96f35-4c8f-4386-8161-6a8d4ad9c43a') as Item,
                    medium: this.rawItems.find(({ id }) => id === '08d96f2d-4ebb-4f82-8051-e5ff74cd5968') as Item,
                    large: this.rawItems.find(({ id }) => id === '08d96f2c-0bbf-4b86-82ab-ccb0486293ca') as Item,
                },
            };
        },
    },
    methods: {
        numberToLocaleString(value: number | null | undefined) {
            return numberToLocaleString(value, 2, 2);
        },
        async refreshData(): Promise<void> {
            await this.loadItems();
        },
        async loadItems(): Promise<void> {
            this.isLoading = true;
            try {
                const response = await itemService.getMultiple({
                    pageSize: -1,
                    itemCategoryIds: '08d96e45-cc0a-48fb-89a3-c8f46c60574b',
                    orderBy: 'name asc',
                });
                this.rawItems = response.data;
            } catch (_) {
                // do nothing
            }
            this.isLoading = false;
        },
    },
    created(): void {
        this.setPageTitle([this.$t('engineComparison'), this.$t('ingame')]);
        this.refreshData();
    },
});
</script>
