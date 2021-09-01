import { defineComponent } from 'vue';

export default defineComponent({
    name: 'ViewMixin',
    computed: {
        fixedTitle(): string {
            return 'Starbase Nexus';
        },
    },
    methods: {
        setPageTitle(titleParts: string[]): void {
            document.title = `${titleParts.join(' / ')} - ${this.fixedTitle}`;
        },
    },
});
