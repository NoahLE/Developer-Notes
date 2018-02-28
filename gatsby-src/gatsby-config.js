module.exports = {
    siteMetadata: {
        title: `Blah blah fake title`,
    },
    plugins: [
        `gatsby-plugin-glamor`,
        `gatsby-transformer-remark`,
        {
            resolve: `gatsby-source-filesystem`,
            options: {
                name: `src`,
                path: `${__dirname}/src/content`,
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