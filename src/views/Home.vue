<template>
<div class="home">
    <div class="padding-container">
        <div class="flex flex--stretch-vertical flex--space-between-children flex--wrap-lg">
            <Panel class="flex__item flex__item--w-50-lg">
                <h2>Welcome to the Starbase-Nexus</h2>
                <p>This is an open-source community project to combine all tools and informations out there about the game Starbase at one source, so users don't have to search around the internet.</p>
                <p>This project is dedicated to any political situation in the game nor is it connected to any organization.</p>
                <p>It is an ongoing project, which will be extended with more features in the future. Any tool and information you find in this project may change depending on the development of the project and the game.</p>
                <p>Currently Frozenbyte doesn't give us any secure and up to date ressource for ingame data like an open api or data dumps in the logs, which maybe changes in the future. Until then the only source for the data is the <a href="https://wiki.starbasegame.com" target="_blank"> official wiki page</a>, ingame toolstips and measurements made by players.</p>
                <p>On the top left side you will find the <span class="text--primary"><MenuIconOutline class="svg-icon svg-icon--middle"/> menu</span> with all currently available informations and tools.</p>
                <p>If you want to post <span class="text--primary">feature requests</span> or <span class="text--primary">bug reports</span>, please join our disord:</p>
                <div class="flex flex--center-horizontal">
                    <Button href="https://discord.gg/5uXwMK5D">
                        <img src="https://cdn.starbase-nexus.net/dd1a4bcf-140b-4bb8-906b-93a18739812d/app-assets/Discord-Logo-White.svg" class="svg-icon margin-right--f2"/>
                        Discord
                    </Button>
                </div>
                <p>We invite everybody to contribute to this project. If you want to participate into this project, there are several ways to do it:</p>
                <ul>
                    <li><span class="text--secondary text--bold">Data Management:</span> Currently there are no ways to automatically get data about items f. e. out of the game. If you want to help to gather informations you will get the rights for the ingame data management.</li>
                    <li class="margin-top"><span class="text--secondary text--bold">Coding:</span> If you want to include new tools or features into this project, the whole code is open source.</li>
                    <ul>
                        <li>API: <a href="https://github.com/WildChild85/starbase-nexus-api" target="_blank">https://github.com/WildChild85/starbase-nexus-api</a></li>
                        <li>API-Docs: <a href="https://api.starbase-nexus.net/swagger" target="_blank">https://api.starbase-nexus.net/swagger</a></li>
                        <li>UI: <a href="https://github.com/WildChild85/starbase-nexus-ui" target="_blank">https://github.com/WildChild85/starbase-nexus-ui</a></li>
                    </ul>
                </ul>
                <p>For any contributions, please contact <span class="text--primary text--bold">WildChild85#2691</span> and I will give you an instruction on how you can participate.</p>
                <h2>Private Data and Login</h2>
                <p>We don't use any tracker nor do we save any private data currently. The login is handled via discord oauth 2 and we only save the discord user id and username, so we don't save or request an email address or anything personal. You can validate this by checking the source code in the repositories linked above.</p>
                <p>You currently don't need a user account to use many of the tools on this website. Some features maybe need data to be stored on the server, that is connected to your user account, so only you have the rigtht to view or edit it. In this case you will have to sign in with the discord sign in. This will not give us any access to anything on discord.</p>
            </Panel>
            <Panel class="flex__item flex__item--w-50-lg">
                <h2>Feature Roadmap</h2>
                <div class="x-scroll">
                    <DataTable class="margin-top full-width">
                        <DataTableRow>
                            <DataTableCell>Extendable Open Api</DataTableCell>
                            <DataTableCell>WildChild85#2691</DataTableCell>
                            <DataTableCell type="success">done</DataTableCell>
                        </DataTableRow>
                        <DataTableRow>
                            <DataTableCell>Extendable Frontend Framework</DataTableCell>
                            <DataTableCell>WildChild85#2691</DataTableCell>
                            <DataTableCell type="success">done</DataTableCell>
                        </DataTableRow>
                        <DataTableRow>
                            <DataTableCell>Ingame Data Management</DataTableCell>
                            <DataTableCell>WildChild85#2691</DataTableCell>
                            <DataTableCell type="success">done</DataTableCell>
                        </DataTableRow>
                        <DataTableRow>
                            <DataTableCell>Engine Comparison</DataTableCell>
                            <DataTableCell>WildChild85#2691</DataTableCell>
                            <DataTableCell type="success">done</DataTableCell>
                        </DataTableRow>
                        <DataTableRow>
                            <DataTableCell>Maps</DataTableCell>
                            <DataTableCell>Arch#6267, RustyDawwwg</DataTableCell>
                            <DataTableCell type="success">done</DataTableCell>
                        </DataTableRow>
                        <DataTableRow>
                            <DataTableCell>Ship Calculator</DataTableCell>
                            <DataTableCell>PoLLi#4969</DataTableCell>
                            <DataTableCell type="warning">development</DataTableCell>
                        </DataTableRow>
                        <DataTableRow>
                            <DataTableCell>Yolol Library</DataTableCell>
                            <DataTableCell>WildChild85#2691</DataTableCell>
                            <DataTableCell type="success">done</DataTableCell>
                        </DataTableRow>
                        <DataTableRow>
                            <DataTableCell>Animations</DataTableCell>
                            <DataTableCell>WildChild85#2691</DataTableCell>
                            <DataTableCell type="info">planned</DataTableCell>
                        </DataTableRow>
                        <DataTableRow>
                            <DataTableCell>CDN for Images</DataTableCell>
                            <DataTableCell>WildChild85#2691</DataTableCell>
                            <DataTableCell type="success">done</DataTableCell>
                        </DataTableRow>
                        <DataTableRow>
                            <DataTableCell>Ship Shop</DataTableCell>
                            <DataTableCell>WildChild85#2691</DataTableCell>
                            <DataTableCell type="info">planned</DataTableCell>
                        </DataTableRow>
                        <DataTableRow>
                            <DataTableCell>Tutorial Library</DataTableCell>
                            <DataTableCell>WildChild85#2691</DataTableCell>
                            <DataTableCell type="info">planned</DataTableCell>
                        </DataTableRow>
                        <DataTableRow>
                            <DataTableCell>3D-Map</DataTableCell>
                            <DataTableCell><span class="text--error">open</span></DataTableCell>
                            <DataTableCell type="info">planned</DataTableCell>
                        </DataTableRow>
                        <DataTableRow>
                            <DataTableCell>Bounty-System</DataTableCell>
                            <DataTableCell><span class="text--error">open</span></DataTableCell>
                            <DataTableCell type="info">planned</DataTableCell>
                        </DataTableRow>
                        <DataTableRow>
                            <DataTableCell>InGame Events Announcements</DataTableCell>
                            <DataTableCell><span class="text--error">open</span></DataTableCell>
                            <DataTableCell type="info">planned</DataTableCell>
                        </DataTableRow>
                        <DataTableRow>
                            <DataTableCell>InGame Organizations Register</DataTableCell>
                            <DataTableCell><span class="text--error">open</span></DataTableCell>
                            <DataTableCell type="info">planned</DataTableCell>
                        </DataTableRow>
                        <DataTableRow>
                            <DataTableCell>Discord</DataTableCell>
                            <DataTableCell>{{ nukNuk }}</DataTableCell>
                            <DataTableCell type="success">done</DataTableCell>
                        </DataTableRow>
                    </DataTable>
                </div>
            </Panel>
        </div>
    </div>
</div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import Panel from '@/components/layout/Panel.vue';
import ViewMixin from '@/mixins/ViewMixin';
import DataTable from '@/components/layout/dataTable/DataTable.vue';
import DataTableRow from '@/components/layout/dataTable/DataTableRow.vue';
import DataTableCell from '@/components/layout/dataTable/DataTableCell.vue';
import Button from '@/components/controls/Button';

export default defineComponent({
    name: 'Home',
    components: {
        Button,
        DataTable,
        DataTableRow,
        DataTableCell,
        Panel,
    },
    mixins: [ViewMixin],
    data: () => ({
    }),
    computed: {
        nukNuk(): string {
            return ',̶̀̾-̵͋̇*̵̛͊.̵̽̒≮͕́~̶̔̓-̸̓̽#1695';
        },
    },
    async created(): Promise<void> {
        this.setPageTitle(['InGame', 'Items']);
    },
});
</script>
