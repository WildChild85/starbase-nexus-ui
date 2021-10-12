<template>
<div>
    <div class="ship__info-matrix">
        <div class="ship__property-group">
            <div class="ship__property-group-title" data-augmented-ui="b-clip-x border">{{ $t('purchasing') }}</div>
            <div class="ship__properties">
                <ShipProperty
                    :title="$t('priceBlueprint')"
                    :value="ship ? ship.priceBlueprint : null"
                    :formatNumber="true"
                />
                <ShipProperty
                    :title="$t('priceShip')"
                    :value="ship ? ship.priceShip : null"
                    :formatNumber="true"
                />
            </div>
        </div>
        <div class="ship__property-group">
            <div class="ship__property-group-title" data-augmented-ui="b-clip-x border">{{ $t('flightParameters') }}</div>
            <div class="ship__properties">
                <ShipProperty
                    :title="$t('flightTimeNoExp')"
                    :value="ship ? ship.flightTime : null"
                    :formatDuration="true"
                />
                <ShipProperty
                    :title="$t('speedWithoutCargo')"
                    :value="ship ? ship.speedWithoutCargo : null"
                    :formatNumber="true"
                />
                <ShipProperty
                    :title="$t('speedWithCargo')"
                    :value="ship ? ship.speedWithCargo : null"
                    :formatNumber="true"
                />
            </div>
        </div>
    </div>

    <div class="ship__info-matrix">
        <div class="ship__property-group">
            <div class="ship__property-group-title" data-augmented-ui="b-clip-x border">{{ $t('dimensions') }}</div>
            <div class="ship__properties">
                <ShipProperty
                    :title="$t('length')"
                    :value="ship ? ship.length : null"
                    :formatNumber="true"
                />
                <ShipProperty
                    :title="$t('height')"
                    :value="ship ? ship.height : null"
                    :formatNumber="true"
                />
                <ShipProperty
                    :title="$t('width')"
                    :value="ship ? ship.width : null"
                    :formatNumber="true"
                />
            </div>
        </div>

        <div class="ship__property-group">
            <div class="ship__property-group-title" data-augmented-ui="b-clip-x border">{{ $t('massAndThrust') }}</div>
            <div class="ship__properties">
                <ShipProperty
                    :title="$t('totalMassWithoutCargo')"
                    :value="ship ? ship.totalMassWithoutCargo : null"
                    :formatNumber="true"
                />
                <ShipProperty
                    :title="$t('forwardThrustPower')"
                    :value="ship ? ship.forwardThrustPower : null"
                    :formatNumber="true"
                />
                <ShipProperty
                    :title="$t('backwardThrustPower')"
                    :value="ship ? ship.backwardThrustPower : null"
                    :formatNumber="true"
                />
            </div>
        </div>
    </div>

    <div class="ship__info-matrix">
        <div class="ship__property-group">
            <div class="ship__property-group-title" data-augmented-ui="b-clip-x border">{{ $t('general') }}</div>
            <div class="ship__properties">
                <ShipProperty
                    :iconUri="typedCompany ? typedCompany.logoUri : 'keep'"
                    :title="$t('company')"
                    :value="typedCompany ? typedCompany.name : null"
                />
                <ShipProperty
                    :iconUri="typedCreator && typedCreator.avatarUri ? typedCreator.avatarUri : 'keep'"
                    :title="$t('creator')"
                    :value="typedCreator ? typedCreator.userName : null"
                />
                <ShipProperty
                    :iconUri="typedArmorMaterial ? typedArmorMaterial.iconUriRaw : 'keep'"
                    :title="$t('armorMaterial')"
                    :value="typedArmorMaterial ? typedArmorMaterial.name : null"
                />
            </div>
        </div>
        <div class="ship__property-group">
            <div class="ship__property-group-title" data-augmented-ui="b-clip-x border">{{ $t('tools') }}</div>
            <div class="ship__properties">
                <ShipProperty
                    iconUri="https://wiki.starbasegame.com/images/9/90/Mining_laser.png"
                    :title="$t('miningLasers')"
                    :value="ship ? ship.miningLasers : null"
                    :formatNumber="true"
                />
                <ShipProperty
                    iconUri="https://wiki.starbasegame.com/images/9/90/Ore_collector.png"
                    :title="$t('oreCollectors')"
                    :value="ship ? ship.oreCollectors : null"
                    :formatNumber="true"
                />
            </div>
        </div>
    </div>

    <div class="ship__info-matrix">
        <div class="ship__property-group">
            <div class="ship__property-group-title" data-augmented-ui="b-clip-x border">{{ $t('storagesAndInterfaces') }}</div>
            <div class="ship__properties">
                <ShipProperty
                    iconUri="https://wiki.starbasegame.com/images/thumb/1/16/H2_Propellant_tank_%28large%29.png/1280px-H2_Propellant_tank_%28large%29.png"
                    :title="$t('propellantCapacity')"
                    :value="ship ? ship.propellantCapacity : null"
                    :formatNumber="true"
                />
                <ShipProperty
                    iconUri="https://cdn.starbase-nexus.net/dd1a4bcf-140b-4bb8-906b-93a18739812d/ingame/items/1920px-Starbase_devices_ore_crate.png"
                    :title="$t('oreCrates')"
                    :value="ship ? ship.oreCrates : null"
                    :formatNumber="true"
                />
                <ShipProperty
                    iconUri="https://wiki.starbasegame.com/images/9/9d/Resource_Port.png"
                    :title="$t('resourceBridges')"
                    :value="ship ? ship.resourceBridges : null"
                    :formatNumber="true"
                />
            </div>
        </div>

        <div class="ship__property-group">
            <div class="ship__property-group-title" data-augmented-ui="b-clip-x border">{{ $t('energyAndCooling') }}</div>
            <div class="ship__properties">
                <ShipProperty
                    iconUri="https://wiki.starbasegame.com/images/thumb/e/eb/Starbase_devices_generator_unit.png/1024px-Starbase_devices_generator_unit.png"
                    :title="$t('generatedPower')"
                    :value="ship ? ship.generatedPower : null"
                    :formatNumber="true"
                />
                <ShipProperty
                    iconUri="https://wiki.starbasegame.com/images/1/13/Battery_nov_2019.png"
                    :title="$t('batteries')"
                    :value="ship ? ship.batteries : null"
                    :formatNumber="true"
                />
                <ShipProperty
                    iconUri="https://wiki.starbasegame.com/images/1/17/Radiator_base.png"
                    :title="$t('radiators')"
                    :value="ship ? ship.radiators : null"
                    :formatNumber="true"
                />
            </div>
        </div>
    </div>

    <div class="ship__info-matrix ship__info-matrix--full-width">
        <div class="ship__property-group">
            <div class="ship__property-group-title" data-augmented-ui="b-clip-x border">{{ $t('primaryWeapons') }}</div>
            <div class="ship__properties">
                <ShipProperty
                    iconUri="https://wiki.starbasegame.com/images/thumb/4/41/Autocannon.png/1920px-Autocannon.png"
                    :title="$t('primaryWeaponsAutoCannons')"
                    :value="ship ? ship.primaryWeaponsAutoCannons : null"
                    :formatNumber="true"
                />
                <ShipProperty
                    iconUri="https://wiki.starbasegame.com/images/thumb/6/60/Laser_weapon.png/1920px-Laser_weapon.png"
                    :title="$t('primaryWeaponsLaserCannons')"
                    :value="ship ? ship.primaryWeaponsLaserCannons : null"
                    :formatNumber="true"
                />
                <ShipProperty
                    iconUri="https://wiki.starbasegame.com/images/thumb/b/b8/Plasma_cannon.png/1920px-Plasma_cannon.png"
                    :title="$t('primaryWeaponsPlasmaCannons')"
                    :value="ship ? ship.primaryWeaponsPlasmaCannons : null"
                    :formatNumber="true"
                />
                <ShipProperty
                    iconUri="https://wiki.starbasegame.com/images/thumb/e/e2/Rail_weapon.png/1920px-Rail_weapon.png"
                    :title="$t('primaryWeaponsRailCannons')"
                    :value="ship ? ship.primaryWeaponsRailCannons : null"
                    :formatNumber="true"
                />
                <ShipProperty
                    iconUri="https://wiki.starbasegame.com/images/4/41/Missile_launcher.png"
                    :title="$t('primaryWeaponsMissileLauncher')"
                    :value="ship ? ship.primaryWeaponsMissileLauncher : null"
                    :formatNumber="true"
                />
                <ShipProperty
                    iconUri="https://wiki.starbasegame.com/images/8/80/Torpedo_launcher.png"
                    :title="$t('primaryWeaponsTorpedoLauncher')"
                    :value="ship ? ship.primaryWeaponsTorpedoLauncher : null"
                    :formatNumber="true"
                />
            </div>
        </div>
    </div>

    <div class="ship__info-matrix ship__info-matrix--full-width">
        <div class="ship__property-group">
            <div class="ship__property-group-title" data-augmented-ui="b-clip-x border">{{ $t('turretWeapons') }}</div>
            <div class="ship__properties">
                <ShipProperty
                    iconUri="https://wiki.starbasegame.com/images/thumb/4/41/Autocannon.png/1920px-Autocannon.png"
                    :title="$t('turretWeaponsAutoCannons')"
                    :value="ship ? ship.turretWeaponsAutoCannons : null"
                    :formatNumber="true"
                />
                <ShipProperty
                    iconUri="https://wiki.starbasegame.com/images/thumb/6/60/Laser_weapon.png/1920px-Laser_weapon.png"
                    :title="$t('turretWeaponsLaserCannons')"
                    :value="ship ? ship.turretWeaponsLaserCannons : null"
                    :formatNumber="true"
                />
                <ShipProperty
                    iconUri="https://wiki.starbasegame.com/images/thumb/b/b8/Plasma_cannon.png/1920px-Plasma_cannon.png"
                    :title="$t('turretWeaponsPlasmaCannons')"
                    :value="ship ? ship.turretWeaponsPlasmaCannons : null"
                    :formatNumber="true"
                />
                <ShipProperty
                    iconUri="https://wiki.starbasegame.com/images/thumb/e/e2/Rail_weapon.png/1920px-Rail_weapon.png"
                    :title="$t('turretWeaponsRailCannons')"
                    :value="ship ? ship.turretWeaponsRailCannons : null"
                    :formatNumber="true"
                />
                <ShipProperty
                    iconUri="https://wiki.starbasegame.com/images/4/41/Missile_launcher.png"
                    :title="$t('turretWeaponsMissileLauncher')"
                    :value="ship ? ship.turretWeaponsMissileLauncher : null"
                    :formatNumber="true"
                />
                <ShipProperty
                    iconUri="https://wiki.starbasegame.com/images/8/80/Torpedo_launcher.png"
                    :title="$t('turretWeaponsTorpedoLauncher')"
                    :value="ship ? ship.turretWeaponsTorpedoLauncher : null"
                    :formatNumber="true"
                />
            </div>
        </div>
    </div>
</div>

</template>

<script lang="ts">
import { defineComponent } from 'vue';
import ShipProperty from '@/components/constructions/ship/ShipProperty.vue';
import { Ship } from '@/interfaces/constructions/ship';
import { Material } from '@/interfaces/ingame/material';
import { PublicUser } from '@/interfaces/social/publicUser';
import { Company } from '@/interfaces/social/company';

export default defineComponent({
    name: 'ShipInfoMatrix',
    components: {
        ShipProperty,
    },
    props: {
        ship: {
            type: Object,
            default: () => null,
        },
        armorMaterial: {
            type: Object,
            default: () => null,
        },
        creator: {
            type: Object,
            default: () => null,
        },
        company: {
            type: Object,
            default: () => null,
        },
    },
    computed: {
        typedShip(): Ship | null{
            return this.ship as Ship | null;
        },
        typedArmorMaterial(): Material | null {
            return this.armorMaterial as Material | null;
        },
        typedCreator(): PublicUser | null {
            return this.creator as PublicUser | null;
        },
        typedCompany(): Company | null {
            return this.company as Company | null;
        },
    },
});
</script>
