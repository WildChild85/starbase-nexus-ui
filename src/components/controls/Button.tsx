import { defineComponent } from 'vue';
import { RouteLocationRaw } from 'vue-router';
// import { Howl, Howler } from 'howler';
import LoadingIndicatorCircle from '@/components/loading/LoadingIndicatorCircle.vue';

// const soundHover = new Howl({
//     src: ['sounds/PremiumBeat_0046_sci_fi_beep_electric_3.wav'],
// });

// const soundClick = new Howl({
//     src: ['sounds/PremiumBeat_0046_sci_fi_beep_electric.wav'],
// });

export default defineComponent({
    name: 'Button',
    components: { LoadingIndicatorCircle },
    props: {
        type: {
            type: String,
            default: 'primary',
        },
        disabled: {
            type: Boolean,
            default: false,
        },
        loading: {
            type: Boolean,
            default: false,
        },
        to: {
            type: Object,
            default: (): RouteLocationRaw | null => null,
        },
        href: {
            type: String,
            default: null,
        },
    },
    computed: {
        classes(): Record<string, boolean> {
            return {
                button: true,
                'button--primary': this.type === 'primary',
                'button--secondary': this.type === 'secondary',
                'button--success': this.type === 'success',
                'button--warning': this.type === 'warning',
                'button--error': this.type === 'error',
                'button--info': this.type === 'info',
                'button--loading': this.loading,
                'button--disabled': this.disabled,
            };
        },
    },
    methods: {
        handleMouseEnter(): void {
            // soundHover.play();
        },
        handleClick(): void {
            // soundClick.play();
        },
    },
    render() {
        const defaultSlotContent = this.$slots.default ? this.$slots.default() : '';

        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        let content: any = defaultSlotContent;

        if (this.loading) {
            content = (
                <div>
                    <div class="button__content">{content}</div>
                    <div class="button__loading-indicator">
                        <LoadingIndicatorCircle/>
                    </div>
                </div>
            );
        }

        if (!this.loading && !this.disabled) {
            if (this.href) {
                return (
                    <a
                        data-augmented-ui="tl-clip tr-clip bl-clip br-clip border"
                        onMouseenter={this.handleMouseEnter}
                        href={this.href}
                        target="_blank"
                        class={this.classes}
                        onClick={this.handleClick}
                    >{content}</a>
                );
            }
            if (this.to) {
                return (
                    <router-link
                        data-augmented-ui="tl-clip tr-clip bl-clip br-clip border"
                        onMouseenter={this.handleMouseEnter}
                        to={this.to} class={this.classes}
                        onClick={this.handleClick}
                    >{content}</router-link>
                );
            }
        }
        return (
            <button
                data-augmented-ui="tl-clip tr-clip bl-clip br-clip border"
                onMouseenter={this.handleMouseEnter}
                class={this.classes}
                disabled={this.disabled || this.loading}
                onClick={this.handleClick}
            >{content}</button>
        );
    },
});
