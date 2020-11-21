const beforeTransaction = async (authorization) => {
  // create the url to call your api with only the merchant name and your user token
  url = `https://our_api.endpoint/blacklisted?user_api_token=${your_test_token_here}&merchant_name=${authorization.merchant}`

  // call the api with the url
    const response = await fetch(url, {
        method: 'GET',
        headers: {'Content-Type': 'application/json'}
    });

    // approve or block the transaction based on the response
    return await response.json().authorized;
    // const json = await response.json();
    // console.log(json.args);
    // return json.authorized;
};
