module.exports = {
    siteMetadata: {
        title: `Blah blah fake title`,
    },
    plugins: [
        `gatsby-plugin-glamor`,
        {
            resolve: `gatsby-source-filesystem`,
            options: {
                name: `src`,
                path: `${__dirname}/src/`,
            },
        },
        {
            resolve: `gatsby-plugin-typography`,
            options: {
                pathToConfigModule: `src/utils/typography`,
            },
        },
    ],
};  