<template>
<router-link
    :to="{name: 'yolol_yolol-project', params: { yololProjectId: yololProject.id }}"
    class="yolol-project-list-item"
    data-augmented-ui="tl-clip tr-clip br-clip bl-clip border"
    :style="previewImageStyle"
>
    <div class="yolol-project-list-item__name">{{ yololProject.name }}</div>
    <div class="yolol-project-list-item__meta">
        <div class="yolol-project-list-item__creator" v-if="creator">by {{ creator.userName }}</div>
        <div class="yolol-project-list-item__likes"><HeartIconSolid class="svg-icon"/> {{ likes }}</div>
    </div>

</router-link>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import { YololProject } from '@/interfaces/yolol/yololProject';
import { PublicUser } from '@/interfaces/social/publicUser';

export default defineComponent({
    name: 'YololProjectListItem',
    props: {
        yololProject: {
            type: Object,
            required: true,
        },
        creator: {
            type: Object,
            default: null,
        },
        likes: {
            type: Number,
            default: 0,
        },
    },
    computed: {
        typedYololProject(): YololProject {
            return this.yololProject as YololProject;
        },
        typedCreator(): PublicUser | null {
            return this.creator as PublicUser | null;
        },
        previewImageStyle(): Record<string, string> {
            return {
                backgroundImage: this.yololProject && this.yololProject.previewImageUri ? `url('${this.yololProject.previewImageUri}')` : '',
            };
        },
    },
});
</script>
