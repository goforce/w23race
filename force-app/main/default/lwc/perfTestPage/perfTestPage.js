import { LightningElement, api, track } from 'lwc';
import runUpdate from '@salesforce/apex/PerfTestServices.runUpdate';

export default class PerfTestPage extends LightningElement {

    sobj = 'Account';
    filter = '';
    num = 1;

    data = [];

    @track error;
    @track results = { runs: 0 };

    handleClick() {
        this.data = [];
        this.results = { runs: 0 };
        this.run();
    }

    handleChange( event ) {
        const field = event.target.name;
        if ( field == 'sobj' ) {
            this.sobj = event.target.value;
        } else if ( field == 'filter' ) {
            this.filter = event.target.value;
        } else if ( field == 'num' ) {
            this.num = event.target.value;
        }
    }

    run() {
        let soql = "select Id from " + this.sobj;
        if ( this.filter ) soql = soql + " where " + this.filter;
        soql = soql + " limit " + this.num;
        runUpdate( { soql: soql } )
            .then( result => {
                this.data.push( result );
                this.error = undefined;
                this.results.runs = this.results.runs + 1;
                this.results.lastrun = result;
                this.calculate();
                this.evaluate();
            })
            .catch(error => {
                this.error = error;
            });
    }

    calculate() {
        // sort results
        this.data.sort( (a, b) => a-b );
        // calculate mean
        let mean = this.data.reduce(function (a, b) {
            return Number(a) + Number(b);
        }) / this.data.length;
        // calculate standard deviation
        let sd = Math.sqrt(this.data.reduce(function (sq, n) {
            return sq + Math.pow(n - mean, 2);
        }, 0) / (this.data.length - 1));
        let cv = sd / mean * 100;
        this.results.mean = mean;
        this.results.cv = cv;
        this.results.counted = this.data.length;
        this.results.data = this.data.join();
    }

    evaluate() {
        if ( this.results.runs >= 100 ) return;
        if ( this.results.runs < 20 ) {
            this.run();
            return;
        }
        if ( this.results.cv <= 5 ) return;
        let a = this.results.mean - this.data[0];
        let b = this.data[this.data.length-1] - this.results.mean;
        if ( a > b ) this.data.splice( 0, 1 );
        else this.data.splice( this.data.length-1, 1 );
        this.run()
    }

    get errorMessages() {
        return this.reduceErrors( this.error );
    }

    reduceErrors( errors ) {
        if ( ! Array.isArray( errors ) ) {
            errors = [errors];
        }
        return (
            errors
                // Remove null/undefined items
                .filter((error) => !!error)
                // Extract an error message
                .map((error) => {
                    // UI API read errors
                    if (Array.isArray(error.body)) {
                        return error.body.map((e) => e.message);
                    }
                    // UI API DML, Apex and network errors
                    else if (error.body && typeof error.body.message === 'string') {
                        return error.body.message;
                    }
                    // JS errors
                    else if (typeof error.message === 'string') {
                        return error.message;
                    }
                    // Unknown error shape so try HTTP status text
                    return error.statusText;
                })
                // Flatten
                .reduce((prev, curr) => prev.concat(curr), [])
                // Remove empty strings
                .filter((message) => !!message)
        );
    }

}