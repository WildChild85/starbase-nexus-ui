// eslint-disable-next-line @typescript-eslint/no-var-requires
const fs = require('fs');

module.exports = {
    configureWebpack: {
        devServer: {
            // https: {
            //     key: fs.readFileSync('./certs/agap-app.local.dev.key'),
            //     cert: fs.readFileSync('./certs/agap-app.local.dev.crt'),
            // },
            watchOptions: {
                ignored: ['node_modules'],
                aggregateTimeout: 300,
                poll: 1500,
            },
            // public: 'agap-app.local.dev',
        },
    },
    pwa: {
        name: 'Starbase Nexus',
        themeColor: '#3ef0f9',
        msTileColor: '#000000',
        appleMobileWebAppCapable: 'yes',
        appleMobileWebAppStatusBarStyle: 'white',

        iconPaths: {
            faviconSVG: 'https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/nexus/Starbase_Nexus_Logo_animated.svg',
            favicon32: 'https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/nexus/Starbase_Nexus_Logo.png',
            favicon16: 'https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/nexus/Starbase_Nexus_Logo.png',
            appleTouchIcon: 'https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/nexus/Starbase_Nexus_Logo.png',
            maskIcon: 'https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/nexus/Starbase_Nexus_Logo_animated.svg',
            msTileImage: 'https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/nexus/Starbase_Nexus_Logo.png',
        },

        manifestOptions: {
            icons: [
                {
                    src: 'https://cdn.hyperion-corporation.de/userstorages/519b6d95-b854-43cf-b2c3-6cbd0dca9ebc/starbase/nexus/Starbase_Nexus_Logo.png',
                    sizes: '256x256',
                    type: 'image/png',
                    purpose: 'any maskable',
                },
            ],
        },
    },
};
