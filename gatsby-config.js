module.exports = {
    siteMetadata: {
        title: `Blah blah fake title`,
    },
    plugins: [
        `gatsby-plugin-glamor`,
        `gatsby-transformer-remark`,
        {
            resolve: `gatsby-remark-prismjs`,
            options: {
                classPrefix: "language-",
            },
        },
        {
            resolve: `gatsby-source-filesystem`,
            options: {
                name: `content`,
                path: `${__dirname}/content`,
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