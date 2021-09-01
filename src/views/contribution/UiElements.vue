<template>
<div class="home">
    <div class="padding-container">
        <Panel>
            <h2>This is a test title</h2>
            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec vitae mauris bibendum, cursus lorem ut, facilisis nunc. Nulla vitae mollis tellus. Proin sollicitudin dui et odio porta, non ornare mi malesuada. Ut auctor nisi sit amet libero laoreet vehicula. Mauris pulvinar vitae nunc at venenatis. Curabitur ultrices in enim pretium tincidunt. Fusce dignissim, risus eu fringilla mollis, arcu leo elementum dui, ullamcorper auctor dolor libero nec diam. Interdum et malesuada fames ac ante ipsum primis in faucibus. Nam eu felis sit amet massa imperdiet placerat vel non lorem. Sed consequat interdum nulla, eu lacinia erat feugiat et. Quisque bibendum neque quis consequat mollis. Sed luctus magna in felis maximus, id dictum nibh fringilla.</p>
            <p>Mauris lectus arcu, scelerisque ut risus vitae, placerat fringilla orci. Curabitur vestibulum nulla quis nisi facilisis finibus. Morbi tellus neque, mollis ac enim dignissim, lobortis gravida risus. Fusce nec leo non sapien sodales efficitur. Quisque imperdiet nisi quis lectus efficitur molestie. Etiam consequat facilisis eros, eget congue ex vulputate ac. Ut vehicula dictum mi, sit amet hendrerit lectus dapibus vel. Morbi dapibus sit amet odio eu bibendum. Donec ullamcorper scelerisque quam non tincidunt. Nulla tristique nibh diam, sit amet maximus nulla ornare volutpat. Nulla orci dolor, tristique non lacinia sagittis, accumsan at metus.</p>
            <div class="flex">
                <Button class="margin-right">Default</Button>
                <Button class="margin-right" :loading="true">Loading</Button>
                <Button :disabled="true">Disabled</Button>
            </div>
            <TextField class="margin-top" v-model="requiredField" :label="'Required Property'" :placeholder="'Something important'" :required="true" />
            <TextField class="margin-top" v-model="errorTest" :label="'Error test'" :placeholder="'Whatever you type here is wrong'" :errors="errors" />
            <TextArea class="margin-top" v-model="description" :label="'Description'" :placeholder="'Some random description'"/>
        </Panel>
    </div>
</div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import Button from '@/components/controls/Button';
import Panel from '@/components/layout/Panel.vue';
import TextField from '@/components/controls/TextField.vue';
import TextArea from '@/components/controls/TextArea.vue';
import ViewMixin from '@/mixins/ViewMixin';

export default defineComponent({
    name: 'UiElements',
    components: {
        Button,
        Panel,
        TextArea,
        TextField,
    },
    mixins: [ViewMixin],
    data: () => ({
        requiredField: '',
        errorTest: '',
        description: '',
    }),
    computed: {
        errors(): string[] {
            return [
                'error 1',
                'error 2',
                'error 3',
            ];
        },
    },
    created(): void {
        this.setPageTitle(['InGame', 'Items']);
    },
});
</script>
