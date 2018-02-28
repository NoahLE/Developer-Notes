import React from "react";

export default ({ data }) => {
    const post = data.markdownRemark;
    console.log(post);
    return (
        <div>
            <h1>{post.frontmatter.title}</h1>
            <h3>Published: {post.frontmatter.publish}</h3>
            <div dangerouslySetInnerHTML={{ __html: post.html }} />
        </div>
    );
};

export const query = graphql`
  query BlogPostQuery($slug: String!) {
    markdownRemark(fields: { slug: { eq: $slug } }) {
      html
      frontmatter {
        title
        publish
      }
    }
  }
`;