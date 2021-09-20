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
                    <DataTableRow>
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
                    </DataTableRow>
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
                        <template v-for="type in thrusterTypes" :key="type">
                            <template v-for="tier in tiers" :key="tier">
                                <DataTableCell class="text--right" v-html="numberToLocaleString(calculated[type][tier].mass)"></DataTableCell>
                            </template>
                        </template>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.plasma.mass)"></DataTableCell>
                    </DataTableRow>

                    <DataTableRow>
                        <DataTableCell>{{ $t('electricInput') }}</DataTableCell>
                        <template v-for="type in thrusterTypes" :key="type">
                            <template v-for="tier in tiers" :key="tier">
                                <DataTableCell class="text--right" v-html="numberToLocaleString(calculated[type][tier].electricInput)"></DataTableCell>
                            </template>
                        </template>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.plasma.electricInput)"></DataTableCell>
                    </DataTableRow>

                    <DataTableRow>
                        <DataTableCell>{{ $t('electricInput') }} {{ $t('withConverter') }}</DataTableCell>
                        <template v-for="type in thrusterTypes" :key="type">
                            <template v-for="tier in tiers" :key="tier">
                                <DataTableCell class="text--right" v-html="numberToLocaleString(calculated[type][tier].electricInputOptimized)"></DataTableCell>
                            </template>
                        </template>
                        <DataTableCell class="text--right"></DataTableCell>
                    </DataTableRow>

                    <DataTableRow>
                        <DataTableCell>{{ $t('propellantInput') }}</DataTableCell>
                        <template v-for="type in thrusterTypes" :key="type">
                            <template v-for="tier in tiers" :key="tier">
                                <DataTableCell class="text--right" v-html="numberToLocaleString(calculated[type][tier].propellantInput)"></DataTableCell>
                            </template>
                        </template>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.plasma.propellantInput)"></DataTableCell>
                    </DataTableRow>

                    <DataTableRow>
                        <DataTableCell>{{ $t('propellantInput') }} {{ $t('withConverter') }}</DataTableCell>
                        <template v-for="type in thrusterTypes" :key="type">
                            <template v-for="tier in tiers" :key="tier">
                                <DataTableCell class="text--right" v-html="numberToLocaleString(calculated[type][tier].propellantInputOptimized)"></DataTableCell>
                            </template>
                        </template>
                        <DataTableCell class="text--right"></DataTableCell>
                    </DataTableRow>

                    <DataTableRow>
                        <DataTableCell>{{ $t('thrustPower') }}</DataTableCell>
                        <template v-for="type in thrusterTypes" :key="type">
                            <template v-for="tier in tiers" :key="tier">
                                <DataTableCell class="text--right" v-html="numberToLocaleString(calculated[type][tier].thrustPower)"></DataTableCell>
                            </template>
                        </template>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.plasma.thrustPower)"></DataTableCell>
                    </DataTableRow>

                    <DataTableRow>
                        <DataTableCell>{{ $t('thrustPerElectricity') }}</DataTableCell>
                        <template v-for="type in thrusterTypes" :key="type">
                            <template v-for="tier in tiers" :key="tier">
                                <DataTableCell class="text--right" v-html="numberToLocaleString(stats[type][tier].thrustPerElectricity)"></DataTableCell>
                            </template>
                        </template>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(stats.plasma.thrustPerElectricity)"></DataTableCell>
                    </DataTableRow>

                    <DataTableRow>
                        <DataTableCell>{{ $t('thrustPerElectricity') }} {{ $t('withConverter') }}</DataTableCell>
                        <template v-for="type in thrusterTypes" :key="type">
                            <template v-for="tier in tiers" :key="tier">
                                <DataTableCell class="text--right" v-html="numberToLocaleString(stats[type][tier].thrustPerElectricityOptimized)"></DataTableCell>
                            </template>
                        </template>
                        <DataTableCell class="text--right"></DataTableCell>
                    </DataTableRow>

                    <DataTableRow>
                        <DataTableCell>{{ $t('thrustPerPropellant') }}</DataTableCell>
                        <template v-for="type in thrusterTypes" :key="type">
                            <template v-for="tier in tiers" :key="tier">
                                <DataTableCell class="text--right" v-html="numberToLocaleString(stats[type][tier].thrustPerPropellant)"></DataTableCell>
                            </template>
                        </template>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(stats.plasma.thrustPerPropellant)"></DataTableCell>
                    </DataTableRow>

                    <DataTableRow>
                        <DataTableCell>{{ $t('thrustPerPropellant') }} {{ $t('withConverter') }}</DataTableCell>
                        <template v-for="type in thrusterTypes" :key="type">
                            <template v-for="tier in tiers" :key="tier">
                                <DataTableCell class="text--right" v-html="numberToLocaleString(stats[type][tier].thrustPerPropellantOptimized)"></DataTableCell>
                            </template>
                        </template>
                        <DataTableCell class="text--right"></DataTableCell>
                    </DataTableRow>

                    <DataTableRow>
                        <DataTableCell>{{ $t('smallPropellantTankDepletionTime') }}</DataTableCell>
                        <template v-for="type in thrusterTypes" :key="type">
                            <template v-for="tier in tiers" :key="tier">
                                <DataTableCell class="text--right"><DurationFormatter :seconds="stats[type][tier].propellantTankDeplectionTime.small"/></DataTableCell>
                            </template>
                        </template>
                        <DataTableCell class="text--right"><DurationFormatter :seconds="stats.plasma.propellantTankDeplectionTime.small"/></DataTableCell>
                    </DataTableRow>

                    <DataTableRow>
                        <DataTableCell>{{ $t('smallPropellantTankDepletionTime') }} {{ $t('withConverter') }}</DataTableCell>
                        <template v-for="type in thrusterTypes" :key="type">
                            <template v-for="tier in tiers" :key="tier">
                                <DataTableCell class="text--right"><DurationFormatter v-if="type !== 'maneuver'" :seconds="stats[type][tier].propellantTankDeplectionTimeOptimized.small"/></DataTableCell>
                            </template>
                        </template>
                        <DataTableCell class="text--right"></DataTableCell>
                    </DataTableRow>

                    <DataTableRow>
                        <DataTableCell>{{ $t('mediumPropellantTankDepletionTime') }}</DataTableCell>
                        <template v-for="type in thrusterTypes" :key="type">
                            <template v-for="tier in tiers" :key="tier">
                                <DataTableCell class="text--right"><DurationFormatter :seconds="stats[type][tier].propellantTankDeplectionTime.medium"/></DataTableCell>
                            </template>
                        </template>
                        <DataTableCell class="text--right"><DurationFormatter :seconds="stats.plasma.propellantTankDeplectionTime.medium"/></DataTableCell>
                    </DataTableRow>

                    <DataTableRow>
                        <DataTableCell>{{ $t('mediumPropellantTankDepletionTime') }} {{ $t('withConverter') }}</DataTableCell>
                        <template v-for="type in thrusterTypes" :key="type">
                            <template v-for="tier in tiers" :key="tier">
                                <DataTableCell class="text--right"><DurationFormatter v-if="type !== 'maneuver'" :seconds="stats[type][tier].propellantTankDeplectionTimeOptimized.medium"/></DataTableCell>
                            </template>
                        </template>
                        <DataTableCell class="text--right"></DataTableCell>
                    </DataTableRow>

                    <DataTableRow>
                        <DataTableCell>{{ $t('largePropellantTankDepletionTime') }}</DataTableCell>
                        <template v-for="type in thrusterTypes" :key="type">
                            <template v-for="tier in tiers" :key="tier">
                                <DataTableCell class="text--right"><DurationFormatter :seconds="stats[type][tier].propellantTankDeplectionTime.large"/></DataTableCell>
                            </template>
                        </template>
                        <DataTableCell class="text--right"><DurationFormatter :seconds="stats.plasma.propellantTankDeplectionTime.large"/></DataTableCell>
                    </DataTableRow>

                    <DataTableRow>
                        <DataTableCell>{{ $t('largePropellantTankDepletionTime') }} {{ $t('withConverter') }}</DataTableCell>
                        <template v-for="type in thrusterTypes" :key="type">
                            <template v-for="tier in tiers" :key="tier">
                                <DataTableCell class="text--right"><DurationFormatter v-if="type !== 'maneuver'" :seconds="stats[type][tier].propellantTankDeplectionTimeOptimized.large"/></DataTableCell>
                            </template>
                        </template>
                        <DataTableCell class="text--right"></DataTableCell>
                    </DataTableRow>

                    <DataTableRow>
                        <DataTableCell>{{ $t('fullSpeedRangeSmallTank') }}</DataTableCell>
                        <template v-for="type in thrusterTypes" :key="type">
                            <template v-for="tier in tiers" :key="tier">
                                <DataTableCell class="text--right" v-html="numberToLocaleString(maxSpeedRanges[type][tier].small / 1000)"></DataTableCell>
                            </template>
                        </template>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(maxSpeedRanges.plasma.small / 1000)"></DataTableCell>
                    </DataTableRow>

                    <DataTableRow>
                        <DataTableCell>{{ $t('fullSpeedRangeSmallTank') }} {{ $t('withConverter') }}</DataTableCell>
                        <template v-for="type in thrusterTypes" :key="type">
                            <template v-for="tier in tiers" :key="tier">
                                <DataTableCell class="text--right" v-html="type !== 'maneuver' ? numberToLocaleString(maxSpeedRangesOptimized[type][tier].small / 1000) : ''"></DataTableCell>
                            </template>
                        </template>
                        <DataTableCell class="text--right"></DataTableCell>
                    </DataTableRow>

                    <DataTableRow>
                        <DataTableCell>{{ $t('fullSpeedRangeMediumTank') }}</DataTableCell>
                        <template v-for="type in thrusterTypes" :key="type">
                            <template v-for="tier in tiers" :key="tier">
                                <DataTableCell class="text--right" v-html="numberToLocaleString(maxSpeedRanges[type][tier].medium / 1000)"></DataTableCell>
                            </template>
                        </template>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(maxSpeedRanges.plasma.medium / 1000)"></DataTableCell>
                    </DataTableRow>

                    <DataTableRow>
                        <DataTableCell>{{ $t('fullSpeedRangeMediumTank') }} {{ $t('withConverter') }}</DataTableCell>
                        <template v-for="type in thrusterTypes" :key="type">
                            <template v-for="tier in tiers" :key="tier">
                                <DataTableCell class="text--right" v-html="type !== 'maneuver' ? numberToLocaleString(maxSpeedRangesOptimized[type][tier].medium / 1000) : ''"></DataTableCell>
                            </template>
                        </template>
                        <DataTableCell class="text--right"></DataTableCell>
                    </DataTableRow>

                    <DataTableRow>
                        <DataTableCell>{{ $t('fullSpeedRangeLargeTank') }}</DataTableCell>
                        <template v-for="type in thrusterTypes" :key="type">
                            <template v-for="tier in tiers" :key="tier">
                                <DataTableCell class="text--right" v-html="numberToLocaleString(maxSpeedRanges[type][tier].large / 1000)"></DataTableCell>
                            </template>
                        </template>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(maxSpeedRanges.plasma.large / 1000)"></DataTableCell>
                    </DataTableRow>

                    <DataTableRow>
                        <DataTableCell>{{ $t('fullSpeedRangeLargeTank') }} {{ $t('withConverter') }}</DataTableCell>
                        <template v-for="type in thrusterTypes" :key="type">
                            <template v-for="tier in tiers" :key="tier">
                                <DataTableCell class="text--right" v-html="type !== 'maneuver' ? numberToLocaleString(maxSpeedRangesOptimized[type][tier].large / 1000) : ''"></DataTableCell>
                            </template>
                        </template>
                        <DataTableCell class="text--right"></DataTableCell>
                    </DataTableRow>

                    <DataTableRow>
                        <DataTableCell :colspan="11" class="text--center">{{ $t('plasmaComparisonExplanation') }}</DataTableCell>
                    </DataTableRow>

                    <DataTableRow>
                        <DataTableCell>{{ $t('requiredAmountForPlasma') }}</DataTableCell>
                        <template v-for="type in thrusterTypes" :key="type">
                            <template v-for="tier in tiers" :key="tier">
                                <DataTableCell class="text--right" v-html="numberToLocaleString(comparedAmount[type][tier])"></DataTableCell>
                            </template>
                        </template>
                        <DataTableCell class="text--right" >-</DataTableCell>
                    </DataTableRow>

                    <DataTableRow>
                        <DataTableCell>{{ $t('mass') }}</DataTableCell>
                        <template v-for="type in thrusterTypes" :key="type">
                            <template v-for="tier in tiers" :key="tier">
                                <DataTableCell class="text--right" v-html="numberToLocaleString(comparedCalculated[type][tier].mass)"></DataTableCell>
                            </template>
                        </template>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.plasma.mass)"></DataTableCell>
                    </DataTableRow>

                    <DataTableRow>
                        <DataTableCell>{{ $t('electricInput') }}</DataTableCell>
                        <template v-for="type in thrusterTypes" :key="type">
                            <template v-for="tier in tiers" :key="tier">
                                <DataTableCell class="text--right" v-html="numberToLocaleString(comparedCalculated[type][tier].electricInput)"></DataTableCell>
                            </template>
                        </template>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.plasma.electricInput)"></DataTableCell>
                    </DataTableRow>

                    <DataTableRow>
                        <DataTableCell>{{ $t('electricInput') }} {{ $t('withConverter') }}</DataTableCell>
                        <template v-for="type in thrusterTypes" :key="type">
                            <template v-for="tier in tiers" :key="tier">
                                <DataTableCell class="text--right" v-html="numberToLocaleString(comparedCalculated[type][tier].electricInputOptimized)"></DataTableCell>
                            </template>
                        </template>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.plasma.electricInputOptimized)"></DataTableCell>
                    </DataTableRow>

                    <DataTableRow>
                        <DataTableCell>{{ $t('propellantInput') }}</DataTableCell>
                        <template v-for="type in thrusterTypes" :key="type">
                            <template v-for="tier in tiers" :key="tier">
                                <DataTableCell class="text--right" v-html="numberToLocaleString(comparedCalculated[type][tier].propellantInput)"></DataTableCell>
                            </template>
                        </template>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.plasma.propellantInput)"></DataTableCell>
                    </DataTableRow>

                    <DataTableRow>
                        <DataTableCell>{{ $t('propellantInput') }} {{ $t('withConverter') }}</DataTableCell>
                        <template v-for="type in thrusterTypes" :key="type">
                            <template v-for="tier in tiers" :key="tier">
                                <DataTableCell class="text--right" v-html="numberToLocaleString(comparedCalculated[type][tier].propellantInputOptimized)"></DataTableCell>
                            </template>
                        </template>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.plasma.propellantInputOptimized)"></DataTableCell>
                    </DataTableRow>

                    <DataTableRow>
                        <DataTableCell>{{ $t('thrustPower') }}</DataTableCell>
                        <template v-for="type in thrusterTypes" :key="type">
                            <template v-for="tier in tiers" :key="tier">
                                <DataTableCell class="text--right" v-html="numberToLocaleString(comparedCalculated[type][tier].thrustPower)"></DataTableCell>
                            </template>
                        </template>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(calculated.plasma.thrustPower)"></DataTableCell>
                    </DataTableRow>

                    <DataTableRow>
                        <DataTableCell>{{ $t('smallPropellantTankDepletionTime') }}</DataTableCell>
                        <template v-for="type in thrusterTypes" :key="type">
                            <template v-for="tier in tiers" :key="tier">
                                <DataTableCell class="text--right"><DurationFormatter :seconds="comparedStats[type][tier].propellantTankDeplectionTime.small"/></DataTableCell>
                            </template>
                        </template>
                        <DataTableCell class="text--right"><DurationFormatter :seconds="stats.plasma.propellantTankDeplectionTime.small"/></DataTableCell>
                    </DataTableRow>

                    <DataTableRow>
                        <DataTableCell>{{ $t('smallPropellantTankDepletionTime') }} {{ $t('withConverter') }}</DataTableCell>
                        <template v-for="type in thrusterTypes" :key="type">
                            <template v-for="tier in tiers" :key="tier">
                                <DataTableCell class="text--right"><DurationFormatter v-if="type !== 'maneuver'" :seconds="comparedStats[type][tier].propellantTankDeplectionTimeOptimized.small"/></DataTableCell>
                            </template>
                        </template>
                        <DataTableCell class="text--right"></DataTableCell>
                    </DataTableRow>

                    <DataTableRow>
                        <DataTableCell>{{ $t('mediumPropellantTankDepletionTime') }}</DataTableCell>
                        <template v-for="type in thrusterTypes" :key="type">
                            <template v-for="tier in tiers" :key="tier">
                                <DataTableCell class="text--right"><DurationFormatter :seconds="comparedStats[type][tier].propellantTankDeplectionTime.medium"/></DataTableCell>
                            </template>
                        </template>
                        <DataTableCell class="text--right"><DurationFormatter :seconds="stats.plasma.propellantTankDeplectionTime.medium"/></DataTableCell>
                    </DataTableRow>

                    <DataTableRow>
                        <DataTableCell>{{ $t('mediumPropellantTankDepletionTime') }} {{ $t('withConverter') }}</DataTableCell>
                        <template v-for="type in thrusterTypes" :key="type">
                            <template v-for="tier in tiers" :key="tier">
                                <DataTableCell class="text--right"><DurationFormatter v-if="type !== 'maneuver'" :seconds="comparedStats[type][tier].propellantTankDeplectionTimeOptimized.medium"/></DataTableCell>
                            </template>
                        </template>
                        <DataTableCell class="text--right"></DataTableCell>
                    </DataTableRow>

                    <DataTableRow>
                        <DataTableCell>{{ $t('largePropellantTankDepletionTime') }}</DataTableCell>
                        <template v-for="type in thrusterTypes" :key="type">
                            <template v-for="tier in tiers" :key="tier">
                                <DataTableCell class="text--right"><DurationFormatter :seconds="comparedStats[type][tier].propellantTankDeplectionTime.large"/></DataTableCell>
                            </template>
                        </template>
                        <DataTableCell class="text--right"><DurationFormatter :seconds="stats.plasma.propellantTankDeplectionTime.large"/></DataTableCell>
                    </DataTableRow>

                    <DataTableRow>
                        <DataTableCell>{{ $t('largePropellantTankDepletionTime') }} {{ $t('withConverter') }}</DataTableCell>
                        <template v-for="type in thrusterTypes" :key="type">
                            <template v-for="tier in tiers" :key="tier">
                                <DataTableCell class="text--right"><DurationFormatter v-if="type !== 'maneuver'" :seconds="comparedStats[type][tier].propellantTankDeplectionTimeOptimized.large"/></DataTableCell>
                            </template>
                        </template>
                        <DataTableCell class="text--right"></DataTableCell>
                    </DataTableRow>

                    <DataTableRow>
                        <DataTableCell>{{ $t('fullSpeedRangeSmallTank') }}</DataTableCell>
                        <template v-for="type in thrusterTypes" :key="type">
                            <template v-for="tier in tiers" :key="tier">
                                <DataTableCell class="text--right" v-html="numberToLocaleString(comparedMaxSpeedRanges[type][tier].small / 1000)"></DataTableCell>
                            </template>
                        </template>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(maxSpeedRanges.plasma.small / 1000)"></DataTableCell>
                    </DataTableRow>

                    <DataTableRow>
                        <DataTableCell>{{ $t('fullSpeedRangeSmallTank') }} {{ $t('withConverter') }}</DataTableCell>
                        <template v-for="type in thrusterTypes" :key="type">
                            <template v-for="tier in tiers" :key="tier">
                                <DataTableCell class="text--right" v-html="type !== 'maneuver' ? numberToLocaleString(comparedMaxSpeedRangesOptimized[type][tier].small / 1000) : ''"></DataTableCell>
                            </template>
                        </template>
                        <DataTableCell class="text--right"></DataTableCell>
                    </DataTableRow>

                    <DataTableRow>
                        <DataTableCell>{{ $t('fullSpeedRangeMediumTank') }}</DataTableCell>
                        <template v-for="type in thrusterTypes" :key="type">
                            <template v-for="tier in tiers" :key="tier">
                                <DataTableCell class="text--right" v-html="numberToLocaleString(comparedMaxSpeedRanges[type][tier].medium / 1000)"></DataTableCell>
                            </template>
                        </template>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(maxSpeedRanges.plasma.medium / 1000)"></DataTableCell>
                    </DataTableRow>

                    <DataTableRow>
                        <DataTableCell>{{ $t('fullSpeedRangeMediumTank') }} {{ $t('withConverter') }}</DataTableCell>
                        <template v-for="type in thrusterTypes" :key="type">
                            <template v-for="tier in tiers" :key="tier">
                                <DataTableCell class="text--right" v-html="type !== 'maneuver' ? numberToLocaleString(comparedMaxSpeedRangesOptimized[type][tier].medium / 1000) : ''"></DataTableCell>
                            </template>
                        </template>
                        <DataTableCell class="text--right"></DataTableCell>
                    </DataTableRow>

                    <DataTableRow>
                        <DataTableCell>{{ $t('fullSpeedRangeLargeTank') }}</DataTableCell>
                        <template v-for="type in thrusterTypes" :key="type">
                            <template v-for="tier in tiers" :key="tier">
                                <DataTableCell class="text--right" v-html="numberToLocaleString(comparedMaxSpeedRanges[type][tier].large / 1000)"></DataTableCell>
                            </template>
                        </template>
                        <DataTableCell class="text--right" v-html="numberToLocaleString(maxSpeedRanges.plasma.large / 1000)"></DataTableCell>
                    </DataTableRow>

                    <DataTableRow>
                        <DataTableCell>{{ $t('fullSpeedRangeLargeTank') }} {{ $t('withConverter') }}</DataTableCell>
                        <template v-for="type in thrusterTypes" :key="type">
                            <template v-for="tier in tiers" :key="tier">
                                <DataTableCell class="text--right" v-html="type !== 'maneuver' ? numberToLocaleString(comparedMaxSpeedRangesOptimized[type][tier].large / 1000) : ''"></DataTableCell>
                            </template>
                        </template>
                        <DataTableCell class="text--right"></DataTableCell>
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
import { MAX_SPEED } from '@/constants/ingame';

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
    return input * bonus;
}

export default defineComponent({
    name: 'ThrusterComparison',
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
        rings: 1,
    }),
    computed: {
        thrusterTypes(): string[] {
            return ['maneuver', 'triangle', 'box'];
        },
        tiers(): string[] {
            return ['tier1', 'tier2', 'tier3'];
        },
        tankSizes(): string[] {
            return ['small', 'medium', 'large'];
        },
        comparedMaxSpeedRanges() {
            // eslint-disable-next-line @typescript-eslint/no-explicit-any
            const comparedMaxSpeedRanges: any = {};
            this.thrusterTypes.forEach((type) => {
                comparedMaxSpeedRanges[type] = {};
                this.tiers.forEach((tier) => {
                    comparedMaxSpeedRanges[type][tier] = {};
                    this.tankSizes.forEach((tankSize) => {
                        comparedMaxSpeedRanges[type][tier][tankSize] = this.comparedStats[type][tier].propellantTankDeplectionTime[tankSize] * MAX_SPEED;
                    });
                });
            });
            return comparedMaxSpeedRanges;
        },
        comparedMaxSpeedRangesOptimized() {
            // eslint-disable-next-line @typescript-eslint/no-explicit-any
            const comparedMaxSpeedRanges: any = {};
            this.thrusterTypes.forEach((type) => {
                if (type === 'maneuver') {
                    return;
                }
                comparedMaxSpeedRanges[type] = {};
                this.tiers.forEach((tier) => {
                    comparedMaxSpeedRanges[type][tier] = {};
                    this.tankSizes.forEach((tankSize) => {
                        comparedMaxSpeedRanges[type][tier][tankSize] = this.comparedStats[type][tier].propellantTankDeplectionTimeOptimized[tankSize] * MAX_SPEED;
                    });
                });
            });
            return comparedMaxSpeedRanges;
        },
        comparedStats() {
            // eslint-disable-next-line @typescript-eslint/no-explicit-any
            const comparedStats: any = {};
            this.thrusterTypes.forEach((type) => {
                comparedStats[type] = {};
                this.tiers.forEach((tier) => {
                    comparedStats[type][tier] = {};
                    comparedStats[type][tier].propellantTankDeplectionTime = {};
                    this.tankSizes.forEach((tankSize) => {
                        comparedStats[type][tier].propellantTankDeplectionTime[tankSize] = (this.items.propellantTanks[tankSize].propellantCapacity as number) / this.comparedCalculated[type][tier].propellantInput;
                    });
                    comparedStats[type][tier].propellantTankDeplectionTimeOptimized = {};
                    if (type !== 'maneuver') {
                        this.tankSizes.forEach((tankSize) => {
                            comparedStats[type][tier].propellantTankDeplectionTimeOptimized[tankSize] = (this.items.propellantTanks[tankSize].propellantCapacity as number) / this.comparedCalculated[type][tier].propellantInputOptimized;
                        });
                    }
                });
            });
            return comparedStats;
        },
        comparedCalculated() {
            const comparedCalculated: any = {};
            this.thrusterTypes.forEach((type) => {
                comparedCalculated[type] = {};
                this.tiers.forEach((tier) => {
                    comparedCalculated[type][tier] = {
                        mass: this.calculated[type][tier].mass * this.comparedAmount[type][tier],
                        electricInput: this.calculated[type][tier].electricInput * this.comparedAmount[type][tier],
                        propellantInput: this.calculated[type][tier].propellantInput * this.comparedAmount[type][tier],
                        thrustPower: this.calculated[type][tier].thrustPower * this.comparedAmount[type][tier],
                    };
                    if (type !== 'maneuver') {
                        comparedCalculated[type][tier].electricInputOptimized = this.calculated[type][tier].electricInputOptimized * this.comparedAmount[type][tier];
                        comparedCalculated[type][tier].propellantInputOptimized = this.calculated[type][tier].propellantInputOptimized * this.comparedAmount[type][tier];
                    }
                });
            });
            return comparedCalculated;
        },
        comparedAmount() {
            const comparedAmounts = {};
            this.thrusterTypes.forEach((type) => {
                comparedAmounts[type] = {};
                this.tiers.forEach((tier) => {
                    comparedAmounts[type][tier] = this.calculated.plasma.thrustPower / this.calculated[type][tier].thrustPower;
                });
            });
            return comparedAmounts;
        },
        maxSpeedRanges() {
            // eslint-disable-next-line @typescript-eslint/no-explicit-any
            const maxSpeedRanges: any = {};
            this.thrusterTypes.forEach((type) => {
                maxSpeedRanges[type] = {};
                this.tiers.forEach((tier) => {
                    maxSpeedRanges[type][tier] = {};
                    this.tankSizes.forEach((tankSize) => {
                        maxSpeedRanges[type][tier][tankSize] = this.stats[type][tier].propellantTankDeplectionTime[tankSize] * MAX_SPEED;
                    });
                });
            });
            maxSpeedRanges.plasma = {};
            this.tankSizes.forEach((tankSize) => {
                maxSpeedRanges.plasma[tankSize] = this.stats.plasma.propellantTankDeplectionTime[tankSize] * MAX_SPEED;
            });
            return maxSpeedRanges;
        },
        maxSpeedRangesOptimized() {
            // eslint-disable-next-line @typescript-eslint/no-explicit-any
            const maxSpeedRanges: any = {};
            this.thrusterTypes.forEach((type) => {
                if (type === 'maneuver') {
                    return;
                }
                maxSpeedRanges[type] = {};
                this.tiers.forEach((tier) => {
                    maxSpeedRanges[type][tier] = {};
                    this.tankSizes.forEach((tankSize) => {
                        maxSpeedRanges[type][tier][tankSize] = this.stats[type][tier].propellantTankDeplectionTimeOptimized[tankSize] * MAX_SPEED;
                    });
                });
            });
            maxSpeedRanges.plasma = {};
            this.tankSizes.forEach((tankSize) => {
                maxSpeedRanges.plasma[tankSize] = this.stats.plasma.propellantTankDeplectionTime[tankSize] * MAX_SPEED;
            });
            return maxSpeedRanges;
        },
        stats() {
            // eslint-disable-next-line @typescript-eslint/no-explicit-any
            const stats: any = {};
            this.thrusterTypes.forEach((type) => {
                stats[type] = {};
                this.tiers.forEach((tier) => {
                    stats[type][tier] = {};
                    stats[type][tier].thrustPerElectricity = this.calculated[type][tier].thrustPower / this.calculated[type][tier].electricInput;
                    stats[type][tier].thrustPerPropellant = this.calculated[type][tier].thrustPower / this.calculated[type][tier].propellantInput;
                    if (type !== 'maneuver') {
                        stats[type][tier].thrustPerElectricityOptimized = this.calculated[type][tier].thrustPower / this.calculated[type][tier].electricInputOptimized;
                        stats[type][tier].thrustPerPropellantOptimized = this.calculated[type][tier].thrustPower / this.calculated[type][tier].propellantInputOptimized;
                    }
                    stats[type][tier].propellantTankDeplectionTime = {};
                    this.tankSizes.forEach((tankSize) => {
                        stats[type][tier].propellantTankDeplectionTime[tankSize] = (this.items.propellantTanks[tankSize].propellantCapacity as number) / this.calculated[type][tier].propellantInput;
                    });
                    stats[type][tier].propellantTankDeplectionTimeOptimized = {};
                    if (type !== 'maneuver') {
                        this.tankSizes.forEach((tankSize) => {
                            stats[type][tier].propellantTankDeplectionTimeOptimized[tankSize] = (this.items.propellantTanks[tankSize].propellantCapacity as number) / this.calculated[type][tier].propellantInputOptimized;
                        });
                    }
                });
            });
            stats.plasma = {
                thrustPerElectricity: this.calculated.plasma.thrustPower / this.calculated.plasma.electricInput,
                thrustPerPropellant: this.calculated.plasma.thrustPower / this.calculated.plasma.propellantInput,
                propellantTankDeplectionTime: {},
            };
            this.tankSizes.forEach((tankSize) => {
                stats.plasma.propellantTankDeplectionTime[tankSize] = (this.items.propellantTanks[tankSize].propellantCapacity as number) / this.calculated.plasma.propellantInput;
            });
            return stats;
        },
        calculated() {
            const calculated: any = {};
            this.thrusterTypes.forEach((type) => {
                calculated[type] = {};
                this.tiers.forEach((tier) => {
                    if (type === 'maneuver') {
                        calculated[type][tier] = {
                            mass: (this.items[type][tier].mass as number),
                            electricInput: (this.items[type][tier].electricInput as number),
                            propellantInput: (this.items[type][tier].propellantInput as number),
                            thrustPower: (this.items[type][tier].thrustPower as number),
                        };
                    } else {
                        calculated[type][tier] = {
                            mass: (this.items.propellantConverter[tier].mass as number)
                                  + (this.items.electricityConverter[tier].mass as number)
                                  + (this.items[type].combustionChamber.mass as number)
                                  + (this.items[type][tier].body.mass as number)
                                  + (this.items[type][tier].nozzle.mass as number),

                            electricInput:
                                (this.items[type].combustionChamber.electricInput as number)
                                + (this.items[type][tier].body.electricInput as number)
                                + (this.items[type][tier].nozzle.electricInput as number),

                            electricInputOptimized:
                                calcOptimizedInput(
                                    (this.items[type].combustionChamber.electricInput as number)
                                    + (this.items[type][tier].body.electricInput as number)
                                    + (this.items[type][tier].nozzle.electricInput as number),
                                    this.items.electricityConverter[tier].electricityConversionBonusFactor as number,
                                ),

                            propellantInput:
                                (this.items[type].combustionChamber.propellantInput as number)
                                + (this.items[type][tier].body.propellantInput as number)
                                + (this.items[type][tier].nozzle.propellantInput as number),

                            propellantInputOptimized:
                                calcOptimizedInput(
                                    (this.items[type].combustionChamber.propellantInput as number)
                                    + (this.items[type][tier].body.propellantInput as number)
                                    + (this.items[type][tier].nozzle.propellantInput as number),
                                    this.items.propellantConverter[tier].propellantConversionBonusFactor as number,
                                ),

                            thrustPower:
                                (this.items[type].combustionChamber.thrustPower as number)
                                + (this.items[type][tier].body.thrustPower as number)
                                + (this.items[type][tier].nozzle.thrustPower as number),

                            //
                        };
                    }
                });
            });
            calculated.plasma = {
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
                        (this.items.plasma.core.electricInput as number)
                        + (((this.items.plasma.superconductor.electricInput as number) * 4) * this.rings),

                propellantInput:
                    (this.items.plasma.core.propellantInput as number)
                    + (((this.items.plasma.superconductor.propellantInput as number) * 4) * this.rings),

                thrustPower:
                    ((this.items.plasma.nozzle.thrustPower as number) * 2)
                    + (this.items.plasma.core.thrustPower as number)
                    + (((this.items.plasma.superconductor.thrustPower as number) * 4) * this.rings),
            };
            return calculated;
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
        this.setPageTitle([this.$t('thrusterComparison'), this.$t('ingame')]);
        this.refreshData();
    },
});
</script>
