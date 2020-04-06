import axios from 'axios';
const publicIp = require('public-ip');
 
var ip;
var API_URL;

const getIp = async () => {
	ip = await publicIp.v4();
	
		API_URL = 'http://' + ip + ':80';
}
export default class CustomersService{

	async getCustomers() {
		await getIp();
		console.log("THE IP" + ip);
        console.log("get customers");
		const url = `${API_URL}/api/customers/`;
		return axios.get(url).then(response => response.data);
	}

	getCustomersByURL(link){
		const url = `${API_URL}${link}`;
		return axios.get(url).then(response => response.data);
	}

	getCustomer(pk) {
		const url = `${API_URL}/api/customers/${pk}`;
		return axios.get(url).then(response => response.data);
	}

	deleteCustomer(customer){
		const url = `${API_URL}/api/customers/${customer.pk}`;
		return axios.delete(url);
	}

	createCustomer(customer){
		const url = `${API_URL}/api/customers/`;
		return axios.post(url,customer);
	}

	updateCustomer(customer){
		const url = `${API_URL}/api/customers/${customer.pk}`;
		return axios.put(url,customer);
	}
}