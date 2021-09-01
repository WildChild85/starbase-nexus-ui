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

        // iconPaths: {
        //     faviconSVG: 'https://res.cloudinary.com/as-good-as-pros-sports-gmbh/image/upload/v1613921166/agap-coding-01_n84ido.svg',
        //     favicon32: 'https://res.cloudinary.com/as-good-as-pros-sports-gmbh/image/upload/v1613921166/agap-coding-01_256_ejk4l3.png',
        //     favicon16: 'https://res.cloudinary.com/as-good-as-pros-sports-gmbh/image/upload/v1613921166/agap-coding-01_256_ejk4l3.png',
        //     appleTouchIcon: 'https://res.cloudinary.com/as-good-as-pros-sports-gmbh/image/upload/v1613921166/agap-coding-01_256_ejk4l3.png',
        //     maskIcon: 'https://res.cloudinary.com/as-good-as-pros-sports-gmbh/image/upload/v1613921166/agap-coding-01_n84ido.svg',
        //     msTileImage: 'https://res.cloudinary.com/as-good-as-pros-sports-gmbh/image/upload/v1613921166/agap-coding-01_256_ejk4l3.png',
        // },

        // manifestOptions: {
        //     icons: [
        //         {
        //             src: 'https://res.cloudinary.com/as-good-as-pros-sports-gmbh/image/upload/v1613921166/agap-coding-01_256_ejk4l3.png',
        //             sizes: '256x256',
        //             type: 'image/png',
        //             purpose: 'any maskable',
        //         },
        //     ],
        // },
    },
};
